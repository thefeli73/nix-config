# Felix's NixOS Configuration

A modular, flake-based NixOS configuration supporting multiple hosts with shared and host-specific configurations.

![fastfetch screenshot](screenshots/fastfetch.png)

## 🏗️ Structure Overview

```
nix-config/
├── flake.nix                 # Main flake definition with inputs and outputs
├── hosts/                    # Host-specific configurations
│   ├── wildfire/            # Desktop workstation (AMD GPU)
│   └── hurricane/           # Laptop/secondary system
├── modules/                  # Shared configuration modules
│   ├── common.nix           # Base system configuration
│   ├── programs.nix         # System-wide packages and programs
│   ├── hm/                  # Home Manager configurations
│   └── desktops/            # Desktop environment configurations
└── rebuild-nix-system.sh    # Helper script for system rebuilds
```

## 🖥️ Hosts

### Wildfire (Desktop Workstation)

- **GPU**: AMD with `lact` daemon for GPU control
- **Features**: Gaming setup with Steam, DaVinci Resolve, Ardour
- **Special**: LUKS encryption, dedicated GPU configuration

### Hurricane (Laptop/Secondary)

- **Type**: Portable system
- **Features**: Basic desktop setup with power management
- **Special**: Touchpad support, power profiles

Both hosts use:

- **Desktop**: Hyprland (Wayland compositor)
- **Display Manager**: regreet (lightweight Wayland greeter)
- **Audio**: PipeWire with ALSA and PulseAudio compatibility
- **Security**: Firejail sandboxing for browsers, Yubikey support

## 🧩 Modules

### `modules/common.nix`

Base system configuration shared across all hosts:

- **User Management**: Main user `schulze` with shell and groups
- **Boot**: systemd-boot with latest kernel
- **Networking**: NetworkManager with firewall
- **Localization**: Swedish locale with English UI
- **Security**: Core dump disabled, firewall enabled, ClamAV antivirus
- **Home Manager**: Integration and user-specific imports
- **System**: Auto-upgrades, fonts, and core settings

### `modules/programs.nix`

System-wide packages and program configurations:

- **Development**: VS Code (Cursor), Git, Python, Node.js, etc.
- **CLI Tools**: Modern alternatives (zoxide, starship, fish)
- **Security**: GPG, OpenSSL, Yubikey tools
- **Applications**: Firefox, Thunderbird, LibreOffice, media tools
- **Virtualization**: Docker, libvirt/QEMU with virt-manager

### `modules/desktops/hyprland-desktop.nix`

Hyprland desktop environment setup:

- **Compositor**: Hyprland with UWSM session management
- **Portal**: XDG desktop portal for Wayland
- **Workflow**: Waybar, Rofi, Mako notifications
- **Theming**: Gruvbox theme with consistent fonts
- **Tools**: Screenshot tools, clipboard manager, file manager

### `modules/hm/`

Home Manager configurations:

- **`hyprland.nix`**: User-specific Hyprland configuration
- **`home-manager.nix`**: Base Home Manager settings

## 🚀 Usage

### Building and Switching

```bash
# Build and switch to new configuration
sudo nixos-rebuild switch --flake .#hostname

# Or use the helper script
./rebuild-nix-system.sh
```

### Updating the System

```bash
# Update flake inputs
nix flake update

# Update and rebuild
./update-nix-system.sh
```

## 🔒 Security Features

- **Sandboxing**: Browsers run in Firejail containers
- **Firewall**: Enabled by default, minimal open ports
- **Antivirus**: ClamAV with automatic signature updates
- **Authentication**: Yubikey U2F support
- **Encryption**: LUKS disk encryption (wildfire)
- **Updates**: Automatic security updates at 02:00

## 🎨 Theming and UI

- **Theme**: Gruvbox Dark
- **Icons**: Flat-Remix-Red-Dark
- **Fonts**: Intel One Mono, Noto Sans
- **Terminal**: Ghostty with Fish shell
- **Launcher**: Rofi (Wayland)
- **Notifications**: Mako

## 📦 Package Management

### System Packages

- Defined in `modules/programs.nix`
- Available system-wide for all users

### Host-Specific Packages

- Added in individual host `configuration.nix` files
- Only installed on that specific host

### User Packages

- Managed through Home Manager
- Per-user configurations in `modules/hm/`

## 🔄 Development Workflow

### Code Style

- Use `alejandra` for Nix code formatting
- Comment complex configurations
- Group related settings together
