{ config, pkgs, ... }:
{

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ]; # Allow HTTP and HTTPS
    interfaces.podman1 = {
      allowedUDPPorts = [ 53 ]; # Needed for containers to resolve DNS, try turning it off after getting the setup working
    };
  };

  environment.systemPackages = with pkgs; [
    podman
    podman-compose
    nss_latest
  ];

  system.activationScripts = {
    script.text = ''
      install -d -m 0755 /etc/nixos/containers/caddy/data -o root -g root
      install -d -m 0755 /etc/nixos/containers/caddy/config -o root -g root
      install -d -m 0755 /etc/nixos/containers/stirling-pdf/extraConfig -o root -g root
      install -d -m 0755 /etc/nixos/containers/stirling-pdf/trainingData -o root -g root
      '';
  };

  systemd.services.create-podman-network = with config.virtualisation.oci-containers; {
    serviceConfig.Type = "oneshot";
    wantedBy = [ "${backend}-caddy.service" ];
    script = ''
      ${pkgs.podman}/bin/podman network exists pod-net || \
      ${pkgs.podman}/bin/podman network create pod-net
      '';
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
    oci-containers = {
      backend = "podman";
      containers = {
        caddy = import ./containers/caddy.nix {inherit config; };
        it-tools = import ./containers/it-tools.nix;
        stirling-pdf = import ./containers/stirling-pdf.nix;
      };
    };
  };
}
