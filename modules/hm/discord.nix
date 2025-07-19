{
  programs.vesktop = {
    enable = true;
    settings = {
      appBadge = false;
      arRPC = true;
      checkUpdates = false;
      customTitleBar = false;
      disableMinSize = true;
      minimizeToTray = true;
      tray = true;
      staticTitle = true;
      hardwareAcceleration = true;
      discordBranch = "stable";
      enableSplashScreen = false;
    };
    vencord = {
      themes = {
        "gruvbox-medium-dark" = ''
          :root, body, html, #root, #app, #app-mount {
            background: transparent!important;
          }
          .theme-dark,
          .theme-light {
            --header-primary: #ebdbb2;
            --header-secondary: #a89984;
            --text-normal: #ebdbb2;
            --text-muted: #928374;
            --text-link: #458588;
            --channels-default: #fbf1c7;
            --interactive-normal: #d5c4a1;
            --interactive-hover: #83a598;
            --interactive-active: #83a598;
            --interactive-muted: #bdae93;
            --background-base-lowest: #28282890;
            --background-base-lower: #28282810;
            --background-surface-high: #32302f90;
            --background-primary: #28282810;
            --background-secondary: #28282810;
            --background-secondary-alt: #32302f;
            --background-tertiary: #1d2021;
            --background-accent: #1d2021;
            --background-floating: #18191c90;
            --background-mobile-primary: #36393f50;
            --background-mobile-secondary: #2f313650;
            --background-modifier-hover: rgba(79, 84, 92, 0.16);
            --background-modifier-active: rgba(79, 84, 92, 0.24);
            --background-modifier-selected: rgba(79, 84, 92, 0.32);
            --background-modifier-accent: hsla(0, 0%, 100%, 0.06);
            --background-mentioned: rgba(250, 166, 26, 0.05);
            --background-mentioned-hover: rgba(250, 166, 26, 0.08);
            --background-message-hover: rgba(4, 4, 5, 0.07);
            --background-help-warning: rgba(250, 166, 26, 0.1);
            --background-help-info: rgba(0, 176, 244, 0.1);
            --scrollbar-thin-thumb: #202225;
            --scrollbar-thin-track: transparent;
            --scrollbar-auto-thumb: #1d2021;
            --scrollbar-auto-track: #3c383610;
            --scrollbar-auto-scrollbar-color-thumb: #202225;
            --scrollbar-auto-scrollbar-color-track: #2f313610;
            --elevation-stroke: 0 0 0 1px rgba(4, 4, 5, 0.15);
            --elevation-low: 0 1px 0 rgba(4, 4, 5, 0.2), 0 1.5px 0 rgba(6, 6, 7, 0.05),
              0 2px 0 rgba(4, 4, 5, 0.05);
            --elevation-medium: 0 4px 4px rgba(0, 0, 0, 0.16);
            --elevation-high: 0 8px 16px rgba(0, 0, 0, 0.24);
            --logo-primary: #fff;
            --focus-primary: #00b0f4;
            --radio-group-dot-foreground: #000000;
            --guild-header-text-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
            --channeltextarea-background: #3c3836;
            --activity-card-background: #202225;
            --textbox-markdown-syntax: #8e9297;
            --deprecated-card-bg: rgba(32, 34, 37, 0.6);
            --deprecated-card-editable-bg: rgba(32, 34, 37, 0.3);
            --deprecated-store-bg: #36393f;
            --deprecated-quickswitcher-input-background: #3c3836;
            --deprecated-quickswitcher-input-placeholder: hsla(0, 0%, 100%, 0.3);
            --deprecated-text-input-bg: rgba(0, 0, 0, 0.1);
            --deprecated-text-input-border: rgba(0, 0, 0, 0.3);
            --deprecated-text-input-border-hover: #040405;
            --deprecated-text-input-border-disabled: #202225;
            --deprecated-text-input-prefix: #dcddde;
            --red-faded: #fb4934;
            --red-intense: #cc241d;
            --rs-online-color: #689d6a;
            --rs-idle-color: #d79921;
            --rs-dnd-color: #cc241d;
            --rs-streaming-color: #b16286;
            --rs-offline-color: #504945;
            --rs-invisible-color: #1d2021;
          }

          [class*="guilds"][class*="guilds"] {
            background-color: transparent;
          }

          [class*="lookFilled"][class*="colorBrand"] {
            color: var(--text-normal);
            background-color: var(--background-floating); /* settings buttons */
          }

          [class*="lookFilled"][class*="colorRed"] {
            color: var(--text-normal);
            background-color: var(--red-faded); /* disable account */
          }

          [class*="lookOutlined"][class*="colorRed"] {
            color: var(--red-intense);
            border-color: var(--red-intense); /* 2fa delete account */
          }

          [class*="lookFilled"][class*="colorGrey"] {
            color: var(--text-normal);
            background-color: var(--background-floating); /* edit buttons */
          }

          [class*="wrapper"][class*="selected"] [class*="childWrapper"],
          [class*="wrapper"]:hover [class*="childWrapper"] {
            color: var(--text-normal);
            background-color: var(--background-floating); /* discord logo */
          }

          [class*="colorDefault"][class*="focused"] {
            background-color: #282828;
            color: var(--text-normal); /* right-click menu */
          }

          #friends,
          .da-itemCard,
          .da-nowPlayingScroller,
          .da-peopleList,
          [class*="appMount"],
          [class*="applicationStore"],
          [class*="article"],
          [class*="body"],
          [class*="channels"],
          [class*="chat"],
          [class*="chat"] form,
          [class*="container"],
          [class*="content"],
          [class*="enabled"]:hover,
          [class*="footer"],
          [class*="gameLibrary"],
          [class*="guildsWrapper"],
          [class*="header"],
          [class*="headerBar"],
          [class*="memberListItem"]:not([class*="popoutDisabled"]):hover,
          [class*="members"],
          [class*="messagesWrapper"],
          [class*="nowPlayingColumn"],
          [class*="peopleList"],
          [class*="root"],
          [class*="title"],
          [class*="typeWindows"],
          [class*="video"] {
            background-color: transparent !important;
          }

          [class*="circleIconButton"] {
            color: #fe8019;
            background-color: var(--background-floating); /*  add/search servers */
          }

          [class*="circleIconButton"][class*="selected"] {
            color: #d65d0e;
            background-color: var(
              --background-floating
            ); /* add/search servers selected */
          }

          .theme-dark [class*="root"] {
            background-color: var(--background-accent); /* screen share menu */
          }

          .theme-dark [class*="footer"] {
            background-color: var(--background-floating);
          }

          .ml2-deleted [class*="markup"],
          .ml2-deleted [class*="markup"] .hljs,
          .ml2-deleted [class*="container"] * {
            color: var(--red-faded) !important;
          }
        '';
      };
      settings = {
        enabledThemes = ["gruvbox-medium-dark.css"];
        autoUpdate = false;
        autoUpdateNotification = false;
        disableMinSize = true;
        transparent = true;
        frameless = true;
        plugins = {
          MessageLogger = {
            enabled = true;
            ignoreSelf = true;
          };
          FakeNitro.enabled = true;
        };
      };
    };
  };
}
