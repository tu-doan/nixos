{ config, pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };

  hardware = {
    graphics = {
      enable32Bit = true;
    };
    bluetooth.enable = true;
  };

  networking = {
    networkmanager = {
      enable = true;
    };
  };

  systemd = {
    packages = with pkgs; [ lact ];

    services = {
      lactd.wantedBy = ["multi-user.target"];
      NetworkManager-wait-online = {
        enable = false;
      };
    };

  };

  time.timeZone = "Asia/Ho_Chi_Minh";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # List packages installed in system profile.
  environment = {
    etc.hosts.enable = false;
    systemPackages = with pkgs; [
      # Common
      brightnessctl
      btop
      curl
      file
      git
      gnumake
      grim
      lact
      libnotify
      kitty
      tmux
      tree
      unzip
      vim
      watch
      wget

      # hyprland
      pyprland
      hyprcursor
      hypridle
      hyprlock
      hyprpaper
      hyprpanel
      hyprpicker

      # Theme
      adwaita-icon-theme # mouse cursor and icons
      gnome-themes-extra # dark adwaita theme

      # Desktop
      mako
      mpv
      pavucontrol
      nautilus
      rofi
      slurp
      soteria
      waybar
      wl-clipboard
      xdg-utils
      zathura
    ];
  };

  programs = {
    firefox = {
      enable = true;
    };

    zsh = {
      enable = true;
      loginShellInit = ''
        if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
          exec Hyprland
        fi
      '';
    };

    _1password = {
      enable = true;
    };

    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "tudoan" ];
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    direnv = {
      enable = true;
      silent = true;
    };
  };

  services = {
    dbus.enable = true;
    blueman.enable = true;
    tailscale.enable = true;
    gvfs.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    # Issue with fprint and password
    # https://discourse.nixos.org/t/problems-loging-in-with-password-when-fprint-is-enabled/65900
    pam.services.hyprlock.rules.auth.fprintd.order = config.security.pam.services.hyprlock.rules.auth.unix.order + 50;
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      autoPrune = {
        enable = true;
        flags = [
          "--all"
          "--volumes"
        ];
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  virtualisation.vmVariant = {
    virtualisation.qemu.options = [
      "-device virtio-vga-gl"
      "-display gtk,gl=on"
    ];
    users.users.tudoan.password = "qwerty";
  };
}
