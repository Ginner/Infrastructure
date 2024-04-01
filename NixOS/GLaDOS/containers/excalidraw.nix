{
  image = "docker.io/excalidraw/excalidraw:latest";

  autoStart = true;

  extraOptions = [
    "--pull=newer"
    "--name=excalidraw"
    "--network=pod-net"
  ];
}
