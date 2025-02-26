{
  description = "Senri";

  inputs.devshell.url = "github:numtide/devshell";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = { self, flake-utils, devshell, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShells.default = let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [ devshell.overlays.default ];

          config.permittedInsecurePackages = [ ];
        };
      in pkgs.devshell.mkShell {
        name = "senri.dev";
        packages = [
          pkgs.pkg-config
          pkgs.gcc
          pkgs.sqlite
          pkgs.gnumake
          pkgs.yarn
          pkgs.ruby_3_1
          pkgs.libyaml.dev
          pkgs.openssl_3_2.dev
          pkgs.postgresql
          pkgs.autoconf269
          pkgs.automake
          pkgs.autogen
          pkgs.libtool
          pkgs.libffi.dev
          pkgs.gnum4
          pkgs.secp256k1
        ];
        env = [
          {
            name = "PKG_CONFIG_PATH";
            value = "${pkgs.pkg-config}:${pkgs.openssl_3_2.dev}/lib/pkgconfig:${pkgs.libyaml.dev}/lib/pkgconfig:${pkgs.postgresql}/lib/pkgconfig:${pkgs.libffi.dev}/lib/pkgconfig:${pkgs.secp256k1}/lib/pkgconfig";
          }
          {
            name = "LIBTOOL";
            value = "${pkgs.libtool}";
          }
          {
            name = "NIXPKGS_ALLOW_INSECURE";
            value = "1";
          }
        ];
        commands = [
          {
            name = "run";
            category = "devshell";
            help = "Run the application";
            command = "bundle exec rails s";
          }
          {
            name = "migrate";
            category = "devshell";
            help = "Migrate the application";
            command = "bundle exec rails db:migrate";
          }
          {
            name = "seed";
            category = "devshell";
            help = "Seed the application";
            command = "bundle exec rails db:seed";
          }
        ];
      };
    });
}
