{
  image = "nextcloud/all-in-one:latest";

  autoStart = true;

  environment = {
    "NEXTCLOUD_MEMORY_LIMIT" = "2048M";
    "APACHE_PORT" = "11000";
    "APACHE_IP_BINDING" = "0.0.0.0";
  };

  extraOptions = [
    "--name=nextcloud-aio-mastercontainer"
    "--sig-proxy=false"
    "--network=bridge"
    "--init"
  ];

  volumes =[
    "nextcloud_aio_mastercontainer:/mnt/docker-aio-config"
    "/var/run/docker.sock:/var/run/docker.sock:ro"
  ];

  ports = [
    "8080:8080"
  ];
}
