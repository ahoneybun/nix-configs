{ pkgs, lib }:

# Thanks to Aires!
# https://aires.fyi/blog/installing-a-custom-package-with-nix/

pkgs.stdenv.mkDerivation rec {
	pname = "backrest";
	version = "v0.11.0";

	src = builtins.fetchurl {
		url = "https://github.com/garethgeorge/backrest/releases/download/v0.11.0/backrest_Linux_x86_64.tar.gz";
		sha256 = "fd6c05339b6855f0acad001c2243d871f4621def04cef9eb3b452110fe175d49";
	};

	doCheck = false;

	dontUnpack = true;

	installPhase = ''
                tar -xf backrest_Darwin_x86_64.tar.gz
		install -D $src $out/backrest
		chmod a+x $out/backrest
	'';

	meta = with lib; {
		homepage = "https://github.com/garethgeorge/backrest";
		description = "Backrest is a web UI and orchestrator for restic backup.";
		platforms = platforms.linux ++ platforms.darwin;
	};
}
