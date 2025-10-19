{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  hardware = {
    graphics = {
      enable32Bit = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      rocmSupport = true;
    };
  };

  networking = {
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
        file = {
          ".config/sway/config.d/hardware".text = ''
            output "eDP-1" {
              scale 2.0
            }
            bindswitch --reload --locked lid:on output eDP-1 disable
            bindswitch --reload --locked lid:off output eDP-1 enable
          '';
        };
      };
    };
  };
}
