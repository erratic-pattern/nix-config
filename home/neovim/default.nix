{ pkgs, lib, vim-tintin, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # add nvim config directory
  xdg.configFile."nvim/" = {
    source = ./config/nvim;
    recursive = true;
  };

  # add vim-tintin syntax file to nvim config directory
  xdg.configFile."nvim/syntax/tt.vim" = {
    source = "${vim-tintin}/syntax/tt.vim";
  };

  # add .vimrc for vim-compatible config that's also sourced by nvim/init.lua
  home.file.".vimrc" = {
    source = ./config/vimrc;
  };

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    # TODO: uncomment for future Linux setup
    # clipboard = {
    # providers = lib.optionalAttrs pkgs.stdenvNoCC.isLinux {
    #   # Required for copying to the system clipboard
    #   wl-copy.enable = wayland;
    #   xclip.enable = !wayland;
    # };
    # };

    withNodeJs = true; # used by copilot

    # fixes issue with rust-analyzer in user PATH shadowing the one here
    # https://github.com/nix-community/home-manager/issues/4330#issuecomment-2391709770
    extraWrapperArgs = [ "--prefix" "PATH" ":" "${lib.makeBinPath [ pkgs.rust-analyzer ]}" ];

    extraPackages = with pkgs; [
      ### LSP servers
      taplo-lsp # TOML
      yaml-language-server # YAML
      nodePackages.typescript-language-server # Typescript/Javascript
      nodePackages.vscode-json-languageserver # JSON
      python3Packages.python-lsp-server # Python
      sumneko-lua-language-server # Lua
      jsonnet-language-server #Jsonnet
      gopls # Go
      buf # Protobuf
      # Bash
      shellcheck
      nodePackages.bash-language-server
      # Nix
      nixd
      nixpkgs-fmt
      # Rust
      rust-analyzer

      ### Telescope dependencies
      ripgrep
      fd
    ];

    plugins = with pkgs.vimPlugins; [

      # Status line, buffer line, tab line
      lualine-nvim

      # Fuzzy Finding / Search
      plenary-nvim
      nvim-web-devicons
      telescope-nvim
      telescope-ui-select-nvim

      # File Exploration and Manipulation
      nvim-tree-lua
      oil-nvim

      # General Editing
      vim-sleuth
      comment-nvim
      indent-blankline-nvim
      undotree
      nvim-colorizer-lua

      # Git integrations
      gitsigns-nvim
      vim-fugitive
      vim-rhubarb

      # GitHub integrations
      nvim-unception
      # gist-nvim
      octo-nvim

      # AI Overlords
      copilot-vim

      # Color Schemes
      nightfox-nvim
      oceanic-next
      palenight-vim
      onehalf
      tokyonight-nvim
      rose-pine
      # zenbones-nvim
      # apprentice # no nix package
      iceberg-vim
      nord-nvim
      tender-vim
      catppuccin-nvim
      melange-nvim
      kanagawa-nvim
      jellybeans-nvim
      seoul256-vim
      srcery-vim
      gruvbox
      dracula-nvim


      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      cmp-path
      cmp-buffer
      cmp-cmdline
      cmp-git

      # LSP
      nvim-lspconfig

      # Syntax
      nvim-treesitter-textobjects
      {
        plugin = nvim-treesitter.withPlugins
          (plugins: with plugins; [
            tree-sitter-json
            tree-sitter-toml
            tree-sitter-yaml
            tree-sitter-rust
            tree-sitter-python
            tree-sitter-nix
            tree-sitter-cmake
            tree-sitter-make
            tree-sitter-cpp
            tree-sitter-c
            tree-sitter-bash
            tree-sitter-readline
            tree-sitter-lua
            tree-sitter-css
            tree-sitter-typescript
            tree-sitter-javascript
            tree-sitter-tsx
            tree-sitter-html
            tree-sitter-http
            tree-sitter-markdown
            tree-sitter-markdown-inline
            tree-sitter-regex
            tree-sitter-vim
            tree-sitter-vimdoc
            tree-sitter-query
            tree-sitter-llvm
            tree-sitter-go
            tree-sitter-zig
            tree-sitter-sql
            tree-sitter-proto
            tree-sitter-dockerfile
            tree-sitter-jsonnet
          ]);
      }
    ];
  };
}

