{
  image = "frooodle/s-pdf:latest";

  environment = {
    DOCKER_ENABLE_SECURITY = "false";
    INSTALL_BOOK_AND_ADVANCED_HTML_OPS = "false";
  };

  autoStart = true;

  dependsOn = [ "caddy" ];

  volumes = [
    "/etc/nixos/containers/stirling-pdf/extraConfig:/configs"
    "/etc/nixos/containers/stirling-pdf/trainingData:/usr/share/tessdata"
  ];

  extraOptions = [
    "--pull=newer"
    "--name=stirling-pdf"
    "--network=pod-net"
  ];
}
