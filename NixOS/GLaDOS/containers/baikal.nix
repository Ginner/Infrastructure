{
  image = "chulka/baikal:nginx";

  autoStart = true;

  volumes = [
    "/etc/nixos/containers/baikal/config:/var/www/baikal/config"
    "/etc/nixos/containers/baikal/data:/var/www/baikal/Specific"
  ];

  extraOptions = [
    "--pull=newer"
    "--name=baikal"
    "--network=pod-net"
  ];
}
