{
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    package = pkgs-unstable.zed-editor;
    extensions = [
      "html"
      "toml"
      "git-firefly"
      "dockerfile"
      "sql"
      "xml"
      "astro"
      "nix"
    ];
    extraPackages = with pkgs; [alejandra nil];
    userSettings = {
      edit_predictions = {
        allow_data_collection = "no";
      };
      agent = {
        favorite_models = [];
        model_parameters = [];
        show_turn_stats = true;
      };
      active_pane_modifiers = {
        inactive_opacity = 0.5;
      };
      minimap = {
        show = "always";
      };
      buffer_font_size = 14.0;
      icon_theme = "Zed (Default)";
      proxy = "";
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      base_keymap = "VSCode";
      auto_install_extensions = {
        html = true;
        toml = true;
        git-firefly = true;
        dockerfile = true;
        sql = true;
        xml = true;
        astro = true;
        nix = true;
      };
      autosave = "on_focus_change";
      format_on_save = "on";
      buffer_font_family = "Intel One Mono";
      terminal = {
        font_family = "Intel One Mono";
      };
      buffer_font_features = {
        ss01 = true;
      };
      tab_size = 2;
      soft_wrap = "editor_width";
      close_on_file_delete = false;
      languages = {
        Nix = {
          language_servers = ["nil" "!nixd"];
          format_on_save = "on";
          formatter = {
            external = {
              command = "alejandra";
              arguments = ["--quiet" "--"];
            };
          };
        };
        Markdown = {
          format_on_save = "on";
          extend_list_on_newline = true;
          indent_list_on_tab = true;
          remove_trailing_whitespace_on_save = false;
        };
      };
      lsp = {
        nil = {
          initialization_options = {
            formatting = {
              command = ["alejandra" "--quiet" "--"];
            };
          };
        };
      };
      theme = "Gruvbox Dark";
      theme_overrides = {
        "Gruvbox Dark" = {
          "background.appearance" = "transparent";
          background = "#4c464230";
          "editor.background" = "#282828cc";
          "editor.gutter.background" = "#00000080";
          "tab_bar.background" = "#00000030";
          "terminal.background" = "#00000030";
          "panel.background" = "#00000030";
          "toolbar.background" = "#00000060";
          "tab.active_background" = "#00000030";
          "tab.inactive_background" = "#00000000";
          "status_bar.background" = "#4C4642b3";
          "title_bar.background" = "#282828b3";
          "editor.active_line.background" = "#00000030";
        };
      };
    };
  };
}
