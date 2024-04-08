{
  image = "corentinth/it-tools:latest";

  autoStart = true;

  extraOptions = [
    "--pull=newer"
    "--name=it-tools"
    "--network=pod-net"
  ];
}
