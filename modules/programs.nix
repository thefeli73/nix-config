{
  pkgs,
  pkgs-unstable,
  ...
}: let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in {
  # Common packages for ALL systems
  environment.systemPackages = with pkgs; [
    # misc
    xdg-user-dirs

    # networking
    wget
    whois
    dig

    # files
    unzip
    ncdu

    # security
    gnupg
    openssl
    kdePackages.kleopatra

    # cli tools
    jq
    yq-go
    pciutils
    glxinfo
    btop
    alejandra
    fzf
    fastfetch
    astroterm # Star map/planetarium

    # Development
    pkgs-unstable.code-cursor
    gitkraken
    git-filter-repo
    git-secrets

    python3
    hugo
    nodejs_22
    pnpm
    cypress
    pgadmin4-desktopmode
    postgresql_15
    beam26Packages.erlang
    beam26Packages.erlfmt
    beam26Packages.erlang-ls
    beam26Packages.rebar3
    gnumake
    gcc
    libgcc
    nil
    sqlite

    # Common programs
    ghostty
    obsidian
    nextcloud-client
    signal-desktop
    slack
    libreoffice-fresh
    tor-browser
    ungoogled-chromium
    plexamp
    remmina

    # Audio / Visual
    loupe # Image viewer
    pastel # generate, analyze, convert and manipulate colors
    inkscape # Vector editor
    krita # Image editor
    kdePackages.kolourpaint # Simple Image editor
    darktable # Raw editor
    imagemagick # Image processing
    mpv # Video player
    cava # Audio visualizer
    wireplumber # Audio server
    pavucontrol # Audio control
  ];

  programs = {
    # CLI tools
    command-not-found = {
      enable = true;
      dbPath = "/run/current-system/sw/bin/sqlite3";
    };

    # Zoxide for quick directory navigation
    zoxide = {
      enable = true;
      flags = ["--cmd cd"];
    };

    # Friendly shell
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      shellAliases = {
        "eza" = "eza --icons=always --color-scale --hyperlink";
      };
      shellAbbrs = {
        # Common abbreviations
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../../";
        "....." = "cd ../../../../";
        "cp" = "cp -v";
        "la" = "eza -la";
        "l" = "eza -l";
        "cat" = "bat -pp";
        "tree" = "eza -lT";
        "mkdir" = "mkdir -p";
        "mv" = "mv -v";
        "rm" = "rm -v";

        # Specific program abbreviations
        "astroterm" = "astroterm --fps 60 --speed 60 --metadata --unicode --color --city Göteborg --label-thresh 1 --threshold 4";

        # Work abbreviations
        "jumpc" = "ssh prod-admin-jump1.infra.csbnet.se";
        "jumpn" = "ssh prod-jump-got1.infra.brainmill.com";
        "proxc" = "ssh -L1337:172.18.200.21:8006 prod-admin-jump1.infra.csbnet.se";
        "proxn" = "ssh -L1338:[2a09:2681:ffff:13::104]:8006 prod-jump-got1.infra.brainmill.com";
        "ups1c" = "ssh -L1339:172.18.79.1:80 prod-admin-jump1.infra.csbnet.se";
        "ups2c" = "ssh -L1340:172.18.79.3:80 prod-admin-jump1.infra.csbnet.se";
      };
    };

    # Starship shell prompt
    starship = {
      enable = true;
      transientPrompt.enable = true;
      presets = ["nerd-font-symbols" "gruvbox-rainbow"];
      settings = {
        add_newline = false;
        directory = {
          fish_style_pwd_dir_length = 1;
        };
      };
    };
    # Direnv for automatic environment loading
    direnv = {
      enable = true;
      enableFishIntegration = true;
    };

    # Cat replacement
    bat = {
      enable = true;
      settings = {
        theme = "gruvbox-dark";
      };
    };

    # Vim editor
    vim = {
      enable = true;
      defaultEditor = true;
    };
    ssh.extraConfig = "";
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    git = {
      enable = true;
      lfs.enable = true;
      config = {
        user.name = "Felix Schulze";
        user.email = "admin@schulze.network";
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
    java.enable = true;

    # programs
    firefox = {
      enable = true;
      nativeMessagingHosts.packages = [pkgs.ff2mpv];
      policies = {
        /*
        ---- POLICIES ----
        */
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        FirefoxHome = {
          Snippets = false;
          TopSites = false;
          SponsoredTopSites = false;
          SponsoredPocket = false;
        };
        HttpsOnlyMode = "force_enabled";
        DNSOverHTTPS = {
          Enabled = true;
          ProviderURL = "https://dns.schulze.network/dns-query";
          Locked = true;
          Fallback = true;
        };
        PasswordManagerEnabled = false;
        /*
        ---- PREFERENCES ----
        */
        Preferences = {
          "extensions.activeThemeID" = {
            Value = "{21ab01a8-2464-4824-bccb-6db15659347e}";
            Status = "locked";
          };
          "sidebar.animation.duration-ms" = {
            Value = 50;
            Status = "locked";
          };
          "sidebar.animation.expand-on-hover.duration-ms" = {
            Value = 50;
            Status = "locked";
          };
          "sidebar.verticalTabs" = lock-true;
          "sidebar.position_start" = lock-false;
        };
        /*
        ---- EXTENSIONS ----
        */
        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked", "force_installed" and "normal_installed".
        ExtensionSettings = {
          "*".installation_mode = "normal_installed";
          # uBlock Origin:
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          # Privacy Badger:
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      };
    };
    thunderbird = {
      enable = true;
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DNSOverHTTPS = {
          Enable = true;
          Provider = "dns.schulze.network";
          Locked = false;
          Fallback = true;
        };
        ExtensionSettings = {
          "cloud@johannes-endres.de" = {
            installation_mode = "force_installed";
            install_url = "https://addons.thunderbird.net/thunderbird/downloads/latest/filelink-nextcloud-owncloud/addon-987761-latest.xpi";
          };
          "dkim_verifier@pl" = {
            installation_mode = "force_installed";
            install_url = "https://addons.thunderbird.net/thunderbird/downloads/latest/dkim-verifier/addon-438634-latest.xpi";
          };
          "gruvbox-dark@calch.themes.thunderbird.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.thunderbird.net/thunderbird/downloads/latest/gruvbox-dark-thunderbird/addon-987835-latest.xpi";
          };
        };
      };
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
    evince.enable = true; # PDF viewer
  };

  # enable and configure Docker
  virtualisation.docker.enable = true;

  # enable VMs
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    spiceUSBRedirection.enable = true;
  };
}
