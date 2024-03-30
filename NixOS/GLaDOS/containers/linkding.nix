{
  image = "sissbruecker/linkding:latest";

  autoStart = true;

  dependsOn = [ "caddy" ];

  volumes = [
    "/etc/nixos/containers/linkding/data:/etc/linkding/data"
  ];

  extraOptions = [
    "--pull=newer"
    "--name=linkding"
    "--network=pod-net"
  ];
}
