{pkgs, ...}: let
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
    pciutils
    glxinfo
    btop
    alejandra
    fzf

    # Development
    code-cursor
    gitkraken
    git-filter-repo
    git-secrets
    python3
    hugo
    nodejs_22
    pnpm
    cypress
    gnumake
    gcc
    libgcc
    nil

    # Common programs
    ghostty
    obsidian
    nextcloud-client
    libreoffice-fresh
    tor-browser
    ungoogled-chromium
    plexamp
    remmina

    # Visual
    inkscape
    krita
    darktable
    imagemagick
  ];

  programs = {
    # CLI
    zoxide = {
      enable = true;
      flags = ["--cmd cd"];
    };
    fish.enable = true;
    starship.enable = true;
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
    };
    java.enable = true;

    # programs
    firefox = {
      enable = true;
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
        /*
        ---- EXTENSIONS ----
        */
        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked",
        # "force_installed" and "normal_installed".
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

        /*
        ---- PREFERENCES ----
        */
        Preferences = {
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
          "extensions.activeThemeID" = {
            Value = "{21ab01a8-2464-4824-bccb-6db15659347e}";
            Status = "locked";
          };
        };
      };
    };
    thunderbird.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
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
