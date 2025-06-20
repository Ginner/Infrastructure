{ config, ... }:

{
  image = "docker.io/traccar/traccar:latest";

  autoStart = true;

  volumes = [
    "/home/ginner/containers/traccar/data:/opt/traccar/data"
    "/home/ginner/containers/traccar/logs:/opt/traccar/logs"
  ];

  ports = [
    "8082:8082"   # Web interface
    "5013:5013"   # GPS tracker port (TCP)
  ];

  dependsOn = [ "traccar-db" ];

  extraOptions = [
    "--pull=newer"
    "--name=traccar"
    "--network=pod-net"
    "--env-file=${config.age.secrets.traccar.path}"
    "--health-cmd=curl -f http://localhost:8082 || exit 1"
    "--health-start-period=30s"
    "--health-timeout=10s"
    "--health-retries=3"
  ];
}
