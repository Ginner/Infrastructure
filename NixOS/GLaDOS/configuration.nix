{ pkgs, config, lib, attrs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./podman-virtualisation.nix
    ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    networkmanager.enable = false;
    hostName = "GLaDOS";
    interfaces.eno1.ipv4.addresses = [{
        address = "192.168.1.18";
        prefixLength = 24;
      }];
    defaultGateway = "192.168.1.1";
    nameservers = ["192.168.1.1" "84.200.69.80" "84.200.70.40"];
  };

  time.timeZone = "Europe/Copenhagen";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "da_DK.UTF-8";
  i18n.extraLocaleSettings = {
    LANG = "en_DK.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "dk";
  services.xserver.xkb.options = "caps:escape";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ginner = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "podman" ];
    packages = with pkgs; [
  #     firefox
  #     tree
    ];
  };

  age.secrets = {
    ghcr-token.file = ./.secrets/ghcr-token.age;
    namecheap-api.file = ./.secrets/namecheap-api.age;
    traccar.file = ./.secrets/traccar.age;
  };

  environment.systemPackages = with pkgs; [
    wget
  #  podman
  #  podman-compose
  #  neovim
    rsync
    tailscale
    attrs.agenix.packages."${pkgs.system}".default
  ];

  # Remove unnecessary default packages.
  environment.defaultPackages = with pkgs; [
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    tmux = {
      enable = true;
      shortcut = "a";
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      escapeTime = 0;
      clock24 = true;
      baseIndex = 1;
      extraConfig = ''
        unbind x
        bind x kill-pane
        bind X confirm-before -p "Kill entire session? (y/n)" kill-session
        bind | split-window -h
        bind - split-window -v
        set -g status-left-length 60
        set -g status-right-length 60
        set -g status-left " [#{session_name}] "
        set -g status-justify absolute-centre
        set -g status-right "#{?window_bigger,[#{window_offset_x}#,#{window_offset_y}] ,}  #{pane_title}  %H:%M %F "
        set -g status-style bg=green,fg=black,bold
      '';
    };
  };

  environment.shellAliases = {
    la = "ls -lAh --color=auto";
    ll = "ls -lh --color=auto";
    cp = "cp -riv";
    mv = "mv -iv";
    rm = "rm -I";
    mkdir = "mkdir -vp";
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "yes";
  };

  services.tailscale.enable = true;

  services.fwupd.enable = true;

  system.stateVersion = "23.11"; # Don't change this

}

