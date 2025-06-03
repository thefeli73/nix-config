{
  config,
  pkgs,
  ...
}: {
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
    python3
    hugo
    nodejs_22
    pnpm
    cypress
    gnumake
    gcc
    libgcc

    # Common programs
    ghostty
    obsidian
    nextcloud-client
    multiviewer-for-f1
    libreoffice-fresh
    tor-browser
    wasabiwallet
    ungoogled-chromium
    prismlauncher
    plexamp
    remmina

    # Visual
    inkscape
    krita
    darktable
    davinci-resolve
    imagemagick
  ];

  programs = {
    # CLI
    zoxide.enable = true;
    fish.enable = true;
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
    firefox.enable = true;
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
