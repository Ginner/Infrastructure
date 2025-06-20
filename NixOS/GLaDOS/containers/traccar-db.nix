{ config, ... }:

{
  image = "docker.io/mariadb:12";

  environment = {
    MYSQL_DATABASE = "traccar";
    MYSQL_USER = "traccar";
  };

  autoStart = true;

  volumes = [
    "/home/ginner/containers/traccar/mysql-data:/var/lib/mysql"
  ];

  extraOptions = [
    "--pull=newer"
    "--name=traccar-db"
    "--network=pod-net"
    "--health-cmd=healthcheck.sh --connect --innodb_initialized"
    "--health-start-period=10s"
    "--health-timeout=5s"
    "--health-retries=5"
    "--env-file=${config.age.secrets.traccar.path}"
  ];
}
