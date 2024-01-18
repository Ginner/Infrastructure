{
    image = "corentinth/it-tools:latest";

    autoStart = true;

    dependsOn = [ "caddy" ];

    extraOptions = [
      "--pull=newer"
      "--name=it-tools"
      "--network=pod-net"
    ];
}
