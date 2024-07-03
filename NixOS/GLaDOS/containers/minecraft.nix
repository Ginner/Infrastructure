{
  image = "itzg/minecraft-server";

  environment = {
    EULA = "TRUE";
  };

  volumes = [
    "/etc/nixos/containers/minecraft/data:/data"
  ];

  extraOptions = [
    "--tty"
    "--stdin-open"
    "--name=minecraft"
  ];
}
