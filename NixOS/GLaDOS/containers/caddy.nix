{
  image = "ghcr.io/ginner/docker-caddy-namecheap:1.0";

  environment = {
    "TZ" = "Europe/Copenhagen";
  };

  volumes = [
    "/etc/nixos/containers/caddy/Caddyfile:/etc/caddy/Caddyfile"
    "/etc/nixos/containers/caddy/data:/data"
    "/etc/nixos/containers/caddy/config:/config"
  ];

  autoStart = true;

  ports = [
    "80:80"
    "443:443"
    "443:443/udp"
  ];

  extraOptions = [
    "--pull=newer"
    "--name=caddy"
    "--hostname=caddy"
    "--network=pod-net"
    "--authfile=/etc/nixos/containers/caddy/.ghcr-token"
  ];
}
