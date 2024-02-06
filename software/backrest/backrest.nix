{ pkgs, config, lib, cfg, ... }:

let
	backrest = pkgs.callPackage ./package.nix { inherit pkgs lib; };
in
rec {
	environment.systemPackages = [
		backrest
	];

	# Install systemd service
	systemd.services."backrest" = {
		enable = true;
		wants = [ "network-online.target" ];
		after = [ "syslog.target" "network-online.target" ];
		description = "Start the Backrest backup service and web UI";
		serviceConfig = {
			Type = "simple";
			ExecStart = ''${backrest/backrest''; 
			Restart = "on-failure";
			RestartSrc = 10;
			KillMode = "process";
			Environment = "HOME=${config.users.users.aaronh.home}";
		};
	};
}
