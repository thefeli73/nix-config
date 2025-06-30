{
  pkgs,
  pkgs-unstable,
  ...
}: {
  # Cursor configuration
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.code-cursor;
    profiles.default.enableUpdateCheck = false;
    profiles.default.enableExtensionUpdateCheck = false;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-python.python # Python language
      ms-python.vscode-pylance # Python LS
      ms-python.black-formatter # Python formatter

      dbaeumer.vscode-eslint # ESLint JS
      esbenp.prettier-vscode # Prettier code formatting
      bradlc.vscode-tailwindcss # Tailwind IntelliSense
      unifiedjs.vscode-mdx # MDX language

      waderyan.gitblame # Git blame

      jdinhlife.gruvbox # Gruvbox theme
      vscode-icons-team.vscode-icons # Icons

      golang.go # Go language
      budparr.language-hugo-vscode # HUGO language
      bungcip.better-toml # TOML

      jnoortheen.nix-ide # Nix language

      redhat.vscode-yaml # YAML
      ms-vscode.hexeditor # Hex editor
      # Manually install these (not available as nixpkgs)
      # pgourlain.erlang # Erlang language # not available
      # csstools.postcss # PostCSS language # not available
    ];
    profiles.default.userSettings = {
      "terminal.external.linuxExec" = "ghostty";
      "terminal.explorerKind" = "external";
      "terminal.integrated.rescaleOverlappingGlyphs" = false;
      "terminal.integrated.fontFamily" = "'Intel One Mono', 'Symbols Nerd Font Mono'";
      "files.autoSave" = "onFocusChange";
      "editor.fontFamily" = "'Intel One Mono', 'Symbols Nerd Font Mono', 'monospace', monospace";
      "editor.tabSize" = 2;
      "editor.wordWrap" = "on";
      "editor.fontLigatures" = "'ss01'";
      "editor.formatOnSave" = true;
      "editor.minimap.enabled" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "prettier.printWidth" = 120;
      "prettier.proseWrap" = "always";
      "workbench.colorTheme" = "Gruvbox Dark Medium";
      "workbench.iconTheme" = "vscode-icons";
      "vsicons.dontShowNewVersionMessage" = true;
      "cursor.cpp.enablePartialAccepts" = true;
      "cursor.diffs.useCharacterLevelDiffs" = true;
      "redhat.telemetry.enabled" = false;
    };
  };
}
