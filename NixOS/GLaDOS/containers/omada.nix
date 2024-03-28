{
  image = "docker.io/mbentley/omada-controller:latest";

  autoStart = true;

  environment = {
    "PUID" = "508";
    "PGID" = "508";
    "MANAGE_HTTP_PORT" = "8088";
    "MANAGE_HTTPS_PORT" = "8043";
    "PORTAL_HTTP_PORT" = "8088";
    "PORTAL_HTTPS_PORT" = "8843";
    "PORT_APP_DISCOVERY" = "27001";
    "PORT_ADOPT_V1" = "29812";
    "PORT_UPGRADE_V1" = "29813";
    "PORT_MANAGER_V1" = "29811";
    "PORT_MANAGER_V2" = "29814";
    "PORT_DISCOVERY" = "29810";
    "PORT_TRANSFER_V2" = "29815";
    "PORT_RTTY" = "29816";
    "SHOW_SERVER_LOGS" = "true";
    "SHOW_MONGODB_LOGS" = "false";
    "TZ" = "Europe/Copenhagen";
  };

  volumes = [
    "/etc/nixos/containers/omada/logs:/opt/tplink/EAPController/logs"
    "/etc/nixos/containers/omada/data:/opt/tplink/EAPController/data"
  ];

  extraOptions = [
    "--pull=newer"
    "--name=omada"
    #"--network=pod-net"
    "--net=host"
  ];
#  ports = [
#    "27001:27001/udp"
#    "29810:29810/udp"
#    "29811:29811/tcp"
#    "29812:29812/tcp"
#    "29813:29813/tcp"
#    "29814:29814/tcp"
#    "29815:29815/tcp"
#    "29816:29816/tcp"
#  ];
}
