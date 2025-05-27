# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "AMEE"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  networking.useNetworkd = true;
  systemd.network.enable = true;
  systemd.network.networks."10-wan" = {
    matchConfig.Name = "enp1s0";
    networkConfig.DHCP = "no";
    address = [
      "65.108.252.203/32"
    ];
    routes = [
      # { routeConfig = { Destination = "172.31.1.1"; }; }
      # { routeConfig = { Gateway = "172.31.1.1"; GatewayOnLink = true; }; }
      { Destination = "172.31.1.1"; }
      { Gateway = "172.31.1.1"; GatewayOnLink = true; }
    ];
  };
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  services.xserver.xkb.layout = "dk";
  services.xserver.xkb.options = "caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ginner = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      neovim
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDeQHdUbtzHloilqWAyfgT5uZ3+EnRzhgRqV/Whhrd+mMs8AFa1e1cIGsS/ncftjiDsJLsYu+7aT9dnpujykBnEeet4KrS+X3WNjTsg/KHP1MsFWCHpzuzIYl2NmylKTTGXmG4R4xabbkwhIIHwg+7ksicVawyc9m+Z17OYI6jRBYDXDUB6bccRpreza/LA57NlWzJPCy2Qv7fanEJHBSi5xKuaJ6V5a6cKd7B8GpD/S2vjwh1iq4cA2gUiyrUIwSZi3+Js9onY/NkI5eOyzsZVbPDEGdoZ+mI/iz0GYRNDQdwf+FfHnW9oWuYFem9TixUdiQzM1O350VkoCfas+Fz6RV8ylxkFnGyp6oigmX1zZJR8/hMmf67DxvfmR/gt+CeoLJ2txR09rs5lpfPGkA5bLUjAzxEGY5QBw/6hX/YAHETu2x5lIRda0aC52UV/nsRVPHKAwtjAxTvAZ+Ka9Frt7h+EZYm62+qr/RE0ub2HQRJZkBZH3bn0h4oRDLJH0q8="
    ];
  };
  users.users.headscale = {
    isSystemUser = true;
    group = "headscale";
    home = "/var/lib/headscale";
    createHome = true;
  };
  users.groups.headscale = {};

  # programs.firefox.enable = true;
  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 8080;
    user = "headscale";
    settings = {
      server_url = "https://headscale.ginnerskov.co";
      database.type = "sqlite";
      database.sqlite.path = "/var/lib/headscale/db.sqlite";
      dns = {
        magic_dns = true; 
        base_domain = "tailnet.ginnerskov.co";
        nameservers.global = [ "100.64.0.6" ]; # V.I.N.CENT
      };
    };
  };
  
  security.acme = {
    acceptTerms = true;
    defaults.email = "headscale-hetz@tty1.dk";
  };
  # networking.firewall.allowedTCPPorts = [ 8080 ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 2248 ];
  };
  
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."headscale.ginnerskov.co" = {
      forceSSL = true;
      enableACME = true;
   
      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
        proxyWebsockets = true;
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
    headscale
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
    ports = [ 2248 ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

