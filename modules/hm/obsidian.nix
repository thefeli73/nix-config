{
  config,
  lib,
  pkgs,
  ...
}: let
  json = pkgs.formats.json {};
  vaultPath = "Obsidian/Felix brain vault";
  vaultHomePath = "${config.home.homeDirectory}/${vaultPath}";
in {
  programs.obsidian.enable = true;

  xdg.configFile = {
    "obsidian/obsidian.json".source = lib.mkForce (json.generate "obsidian.json" {
      vaults.d1112bc6dce7ea81 = {
        path = vaultHomePath;
        ts = 1728741178924;
        open = true;
      };
      frame = "hidden";
      updateDisabled = true;
      cli = true;
    });

    "obsidian/d1112bc6dce7ea81.json".source = json.generate "obsidian-window.json" {
      isMaximized = true;
      devTools = false;
      zoom = -1;
      x = 0;
      y = 0;
      width = 1280;
      height = 1404;
    };
  };

  home.file = {
    "${vaultPath}/.obsidian/app.json".source = json.generate "obsidian-app.json" {
      promptDelete = false;
      newFileLocation = "folder";
      newFileFolderPath = "Zettelkasten";
      attachmentFolderPath = "Files";
      alwaysUpdateLinks = true;
      trashOption = "local";
      mobileToolbarCommands = [
        "editor:insert-wikilink"
        "editor:attach-file"
        "editor:set-heading"
        "editor:toggle-bold"
        "editor:toggle-italics"
        "editor:toggle-strikethrough"
        "editor:toggle-highlight"
        "editor:toggle-code"
        "editor:toggle-blockquote"
        "editor:insert-callout"
        "editor:insert-link"
        "editor:toggle-bullet-list"
        "editor:toggle-numbered-list"
        "editor:toggle-checklist-status"
        "editor:indent-list"
        "editor:unindent-list"
        "editor:undo"
        "editor:redo"
        "editor:insert-footnote"
        "editor:configure-toolbar"
      ];
      tabSize = 2;
      showLineNumber = false;
      strictLineBreaks = false;
      mobilePullAction = "workspace:new-tab";
    };

    "${vaultPath}/.obsidian/appearance.json".source = json.generate "obsidian-appearance.json" {
      accentColor = "#f7ce46";
      cssTheme = "Obsidian gruvbox";
      enabledCssSnippets = [
        "fonts"
        "theme-fix"
      ];
      textFontFamily = "Intel One Mono";
      monospaceFontFamily = "Intel One Mono";
      theme = "obsidian";
    };

    "${vaultPath}/.obsidian/community-plugins.json".source = json.generate "obsidian-community-plugins.json" [
      "remotely-save"
      "table-editor-obsidian"
      "templater-obsidian"
      "cm-editor-syntax-highlight-obsidian"
      "periodic-notes"
      "obsidian-plugin-update-tracker"
      "obsidian-book-search-plugin"
      "obsidian-git"
      "obsidian-excalidraw-plugin"
      "settings-search"
      "omnisearch"
      "text-extractor"
      "recent-files-obsidian"
    ];

    "${vaultPath}/.obsidian/core-plugins.json".source = json.generate "obsidian-core-plugins.json" {
      "file-explorer" = true;
      "global-search" = false;
      switcher = false;
      graph = true;
      backlink = true;
      canvas = false;
      "outgoing-link" = true;
      "tag-pane" = true;
      properties = false;
      "page-preview" = false;
      "daily-notes" = false;
      templates = false;
      "note-composer" = false;
      "command-palette" = true;
      "slash-command" = false;
      "editor-status" = true;
      bookmarks = true;
      "markdown-importer" = false;
      "zk-prefixer" = false;
      "random-note" = false;
      outline = true;
      "word-count" = true;
      slides = false;
      "audio-recorder" = false;
      workspaces = false;
      "file-recovery" = true;
      publish = false;
      sync = false;
      webviewer = false;
      footnotes = false;
      bases = true;
    };
  };
}
