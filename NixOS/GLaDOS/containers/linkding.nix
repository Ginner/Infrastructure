{
  image = "sissbruecker/linkding:latest";

  autoStart = true;

  environment = {
    "LS_ENABLE_AUTH_PROXY" = "False";
  };

  volumes = [
    "/etc/nixos/containers/linkding/data:/etc/linkding/data"
  ];

  extraOptions = [
    "--pull=newer"
    "--name=linkding"
    "--network=pod-net"
  ];
}
