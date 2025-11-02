{ pkgs, ... }:

{
  users.users.tudoan = {
    packages = with pkgs; [
      go
      lua-language-server
      nodejs
      nodePackages.npm
      nodePackages.yarn
      python3
      rust-analyzer
      rustfmt
      tenv
      terraform-ls
      uv
    ];
  };
}
