{
  image = "caddy:2.7-alpine";

  environment = {
    "TZ" = "Europe/Copenhagen";
  };

  volumes = [
    "/etc/nixos/containers/caddy/Caddyfile:/etc/caddy/Caddyfile"
    "/etc/nixos/containers/caddy/data:/data"
    "/etc/nixos/containers/caddy/config:/config"
    "/etc/nixos/containers/caddy/GLaDOS.crt:/etc/caddy/cert.crt"
    "/etc/nixos/containers/caddy/GLaDOS.pem:/etc/caddy/key.pem"
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
  ];
}
