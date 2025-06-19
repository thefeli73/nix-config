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
      # csstools.postcss # PostCSS language # not available

      waderyan.gitblame # Git blame

      jdinhlife.gruvbox # Gruvbox theme
      vscode-icons-team.vscode-icons # Icons

      golang.go # Go language
      budparr.language-hugo-vscode # HUGO language
      bungcip.better-toml # TOML

      jnoortheen.nix-ide # Nix language

      # pgourlain.erlang # Erlang language # not available

      redhat.vscode-yaml # YAML
      ms-vscode.hexeditor # Hex editor
    ];
    profiles.default.userSettings = {
      "files.autoSave" = "onFocusChange";
      "editor.fontFamily" = "'Intel One Mono', 'Droid Sans Mono', 'monospace', monospace";
      "editor.tabSize" = 2;
      "editor.wordWrap" = "on";
      "workbench.colorTheme" = "Gruvbox Dark Medium";
      "workbench.iconTheme" = "vscode-icons";
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.fontLigatures" = "'ss01'";
      "editor.formatOnSave" = true;
      "prettier.printWidth" = 120;
      "prettier.proseWrap" = "always";
      "vsicons.dontShowNewVersionMessage" = true;
      "editor.minimap.enabled" = true;
      "cursor.cpp.enablePartialAccepts" = true;
      "cursor.diffs.useCharacterLevelDiffs" = true;
      "nix.enableLanguageServer" = true;
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
    };
  };
}
