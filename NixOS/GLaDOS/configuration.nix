{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./podman-virtualisation.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "GLaDOS"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Copenhagen";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "da_DK.UTF-8";
  i18n.extraLocaleSettings = {
    LANG = "en_DK.UTF-8";
  };
  console = {
    font = "Lat2-Terminus16";
  #   keyMap = "dk";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "dk";
  services.xserver.xkbOptions = "caps:escape";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ginner = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "podman" ];
    packages = with pkgs; [
  #     firefox
  #     tree
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  #   podman
  #   podman-compose
  ];
  # Remove unnecessary default packages.
  environment.defaultPackages = with pkgs; [
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
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "yes";
  };

  # Enable netbird
  services.netbird.enable = true;

  system.stateVersion = "23.05"; # Don't change this

}

