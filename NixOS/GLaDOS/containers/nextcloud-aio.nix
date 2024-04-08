{
  image = "nextcloud/all-in-one:latest";

  autoStart = true;

  environment = {
    "NEXTCLOUD_MEMORY_LIMIT" = "2048M";
  };

  extraOptions = [
    "--name=nextcloud-aio-mastercontainer"
    "--network=pod-net"
  ];

  volumes =[
    "nextcloud_aio_mastercontainer:/mnt/docker-aio-config"
    "/var/run/docker.sock:/var/run/docker.sock:ro"
  ];
}
