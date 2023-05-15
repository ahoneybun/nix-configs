{
  description = "ahoneybun's NixOS Flake";

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # and `outputs` function will return all the build results of the flake. 
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # There are many ways to reference flake inputs. The most widely used is github:owner/name/reference,
    # which represents the GitHub repository URL + branch/commit-id/tag.

    # Official NixOS package source, using nixos-unstable branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # `outputs` are all the build result of the flake. 
  # A flake can have many use cases and different types of outputs.
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names. 
  # However, `self` is an exception, This special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs: {
    # Outputs named `nixosConfigurations` is used by execute `nixos-rebuild switch --flake /path/to/flakes/directory` on NixOS System.
    nixosConfigurations = {
      # By default, NixOS will try to refer the nixosConfiguration with its hostname.
      # so the system named `nixos-test` will use this configuration.
      # However, the configuration name can also be specified using `nixos-rebuild switch --flake /path/to/flakes/directory#<name>`.
      # The `nixpkgs.lib.nixosSystem` function is used to build this configuration, the following attribute set is its parameter.
      # Run `nixos-rebuild switch --flake .#nixos-test` in the flake's directory to deploy this configuration on any NixOS system
      "harbinger" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        # The Nix module system can modularize configurations, improving the maintainability of configurations.
        #
        # Each parameter in the `modules` is a Nix Module, and there is a partial introduction to it in the nixpkgs manual:
        #    <https://nixos.org/manual/nixpkgs/unstable/#module-system-introduction>
        # It is said to be partial because the documentation is not complete, only some simple introductions
        #    (such is the current state of Nix documentation...)
        # A Nix Module can be an attribute set, or a function that returns an attribute set.
        # If a Module is a function, according to the Nix Wiki description, this function can have up to four parameters:
        # 
        #   config: The configuration of the entire system
        #   options: All option declarations refined with all definition and declaration references.
        #   pkgs: The attribute set extracted from the Nix package collection and enhanced with the nixpkgs.config option.
        #   modulesPath: The location of the module directory of Nix.
        #
        # Only these four parameters can be passed by default.
        # If you need to pass other parameters, you must use `specialArgs` by uncomment the following line
        # specialArgs = {...}  # pass custom arguments into sub module.
        modules = [
          # Import the configuration.nix we used before, so that the old configuration file can still take effect. 
          # Note: /etc/nixos/configuration.nix itself is also a Nix Module, so you can import it directly here
          ./configuration.nix
        ];
      };
    };
  };
}
