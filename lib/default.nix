let
  flatten = list: builtins.foldl' (acc: v: acc ++ v) [ ] list;

  self = {
    githubPlatforms = {
      "x86_64-linux" = "ubuntu-24.04";
      "x86_64-darwin" = "macos-13";
      "aarch64-darwin" = "macos-14";
      "aarch64-linux" = "ubuntu-24.04-arm";
    };

    # Return a GitHub Actions matrix to build relevant derivations
    mkGithubMatrix =
      {
        sourceAttrSet, # Takes an attrset shaped like { x86_64-linux = { hello = pkgs.hello; }; }
        attrPrefix, # Takes the output name, for example "githubActions.checks", "checks", "packages", ...
        lib, # Pass nixpkgs.lib
        platforms ? self.githubPlatforms,
      }:
      let
        formatAttrPath =
          pathList: lib.concatMapStrings (segment: ".${lib.strings.escapeNixString segment}") pathList;
        formatJobName = pathList: lib.concatStringsSep "-" pathList;
        shouldInclude =
          system: drv:
          let
            metaEval = builtins.tryEval drv.meta;
          in
          if !metaEval.success then
            false
          else
            let
              meta = metaEval.value or { };
              drvPlatforms = meta.platforms or (builtins.attrNames platforms);
              noLicenseDefault = false;
              checkLicenseSet =
                licenseSet:
                if licenseSet == null then
                  noLicenseDefault
                else if builtins.isList licenseSet then
                  if licenseSet == [ ] then
                    noLicenseDefault
                  else
                    lib.all (
                      licenseObj:
                      (builtins.tryEval (licenseObj.redistributable or noLicenseDefault)).value or noLicenseDefault
                    ) licenseSet
                else
                  (builtins.tryEval (licenseSet.redistributable or noLicenseDefault)).value or noLicenseDefault;
              redist = checkLicenseSet (meta.license or null);
            in
            lib.elem system drvPlatforms && redist;
        processDerivationEntry =
          system: path: drv:
          if shouldInclude system drv then
            let
              jobName = formatJobName path;
              nestedPathString = formatAttrPath path;
            in
            {
              # Matrix entry record
              name = jobName;
              inherit system;
              os = platforms.${system};
              attr = "${attrPrefix}.${system}${nestedPathString}";
            }
          else
            null;
        findAndProcessDerivations =
          system: pathPrefix: currentExpr:
          if builtins.isAttrs currentExpr then
            let
              names = builtins.attrNames currentExpr;
            in
            lib.lists.concatMap (
              name:
              let
                currentPath = pathPrefix ++ [ name ];
                attempt = builtins.tryEval (
                  let
                    value = currentExpr.${name};
                  in
                  if lib.isDerivation value then
                    processDerivationEntry system currentPath value
                  else if builtins.isAttrs value then
                    findAndProcessDerivations system currentPath value
                  else
                    null
                );
              in
              if !attempt.success then
                [ ]
              else
                let
                  result = attempt.value;
                in
                if builtins.isList result then
                  result
                else if result == null then
                  [ ]
                else
                  [ result ]
            ) names
          else
            [ ];
      in
      {
        matrix = {
          include = flatten (
            builtins.attrValues (
              lib.attrsets.mapAttrs (
                system: systemAttrs:
                if builtins.hasAttr system platforms && builtins.isAttrs systemAttrs then
                  let
                    rawResults = findAndProcessDerivations system [ ] systemAttrs;
                    finalResults = builtins.filter (x: x != null) rawResults;
                  in
                  finalResults
                else
                  [ ]
              ) sourceAttrSet
            )
          );
        };
      };
  };
in
self
