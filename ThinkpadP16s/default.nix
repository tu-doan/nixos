{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelParams = [ "mem_sleep_default=deep" ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 16*1024;
  } ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      rocmSupport = true;
    };
  };

  networking = {
    enableIPv6 = false;
    hostName = "ThinkpadP16s";
  };

  services = {
    fprintd = {
      enable = true;
      tod.enable = true;
      tod.driver = pkgs.libfprint-2-tod1-goodix;
    };
    tlp = {
      enable = true;
      settings = {
        CPU_DRIVER_OPMODE_ON_BAT = "active";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
        RADEON_DPM_PERF_LEVEL_ON_AC = "high";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      };
    };
  };

  home-manager = {
    users.tudoan = {
      home = {
        # swaymsg -t get_outputs
        # to get output ID
        # Because of scale 2.0, our main 3840x2400 monitor's position is divided by 2 ~> 1920x1200
        #
        # ^
        # |                      -----------------------
        # |                     |         DP-1          |
        # |  ------------------ |        2560x1440      |
        # | |       eDP-1      ||                       |
        # | |     1920x1200    ||                       |
        # | |                  ||                       |
        # | |                  ||                       |
        # |  ------------------  -----------------------
        # 0-------------------1920-------------------------->
        file = {
          ".config/sway/config.d/hardware".text = ''
            output "eDP-1" {
              resolution 3840x2400
              scale 2.0
              position 0 240
            }
            output "DP-1" {
              resolution 2560x1440
              scale 1.0
              position 1920 0
            }
            bindswitch --reload --locked lid:on output eDP-1 disable
            bindswitch --reload --locked lid:off output eDP-1 enable
          '';
        };
      };
    };
  };
}
