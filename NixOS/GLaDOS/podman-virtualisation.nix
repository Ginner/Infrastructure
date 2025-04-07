{ config, pkgs, ... }:
{

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80      # Allow HTTP and HTTPS
      443
      29811   # For omada controller
      8088
      8043
      29812
      29813
      29814
      29815
      29816
    ];
    allowedUDPPorts = [
      29810
      27001   # For omada controller
    ];
    interfaces."podman+" = {
      allowedUDPPorts = [ 53 ]; # Needed for containers to resolve DNS, handle multiple/differing podman interfaces
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
        omada = import ./containers/omada.nix;
        linkding = import ./containers/linkding.nix;
        excalidraw = import ./containers/excalidraw.nix;
        baikal = import ./containers/baikal.nix;
        jupyter = import ./containers/jupyter.nix;
      };
    };
  };
}
