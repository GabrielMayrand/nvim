{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true;};
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            pkgs.neovim
            pkgs.tree-sitter
            pkgs.vscode-js-debug
            pkgs.typescript-language-server
            pkgs.vue-language-server
            pkgs.prettierd           
            pkgs.nodejs_22
            pkgs.ripgrep
            pkgs.xclip
            pkgs.luajitPackages.luarocks
            pkgs.lua51Packages.lua
            pkgs.lua-language-server
            pkgs.fzf
            pkgs.ripgrep
            pkgs.fd
            pkgs.gnumake
            pkgs.unzip
            pkgs.vscode-langservers-extracted
            pkgs.netcoredbg
            pkgs.omnisharp-roslyn
	    pkgs.lazygit
          ];
        };
      });
    };
}
