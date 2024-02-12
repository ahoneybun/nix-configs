{ unstable, config, pkgs, ... }:

{
  environment.systemPackages = [
     unstable.legacyPackages."${pkgs.system}".rustc
  ];
}
