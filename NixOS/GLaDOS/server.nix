{ config, lib, pkgs, ... }:

let
    # Define a funvtion to create a virtual host
    #makeVirtualHost = { name, port, sslCert, sslCertKey, ... }@args: { # Maybe remove the @args: bit
    makeVirtualHost = { name, port, ... }: { # Maybe remove the @args: bit
        forceSSL = true;
        enableACME = false;
        sslCertificate = "/etc/ssl/certs/GLaDOS.crt";
        sslCertificateKey = "/etc/ssl/private/GLaDOS.pem";
        serverName = name;
        locations = {
            "/" = {
                proxyPass = "http://localhost:${toString port}";
        };
    };
};
in
            "${name}" = {
                #sslCertificate = sslCert;
                #sslCertificateKey = sslCertKey;
                locations."/" = {
                    proxyPass = "http://localhost:${port}";
                    proxyWebsockets = true;
                    #extraConfig = ''
                    #    proxy_set_header Host $host;
                    #    proxy_set_header X-Real-IP $remote_addr;
                    #    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                    #    proxy_set_header X-Forwarded-Proto $scheme;
                    #    '';
                };
            };
        };
in
{
    options.services.nginx.virtualHosts = lib.mkOption {
            type = lib.types.attrsOf ( lib.types.submodule {
                options = {
                    name = lib.types.str;
                    port = lib.types.int;
                    #sslCert = lib.types.str;
                    #sslCertKey = lib.types.str;
                };
                });
            default = {};
            description = "Virtual hosts for reverse proxying";
        };

        config = {
                services.nginx = let
                nginxVirtualHosts = config.services.nginx.virtualHosts;
                in {
                        enable = true;
                        recommendedOptimizations = true;
                    recommendedGzipSettings = true;
                    recommendedProxySettings = true;
                    recommendedTlsSettings = true;
                    virtualHosts = mapAttrs' (name: vhostconfig:
                        nameValuePair name (makeVirtualHost vhostconfig)
                    ) nginxVirtualHosts;
                    };
            };
}
##
#
#{
#        services.nginx = {
#            enable = true;
#            recommendedOptimizations = true;
#            recommendedGzipSettings = true;
#            recommendedProxySettings = true;
#            recommendedTlsSettings = true;
#            sslCertificate = "/etc/ssl/certs/GLaDOS.crt";
#            sslCertificateKey = "/etc/ssl/private/GLaDOS.pem";
#
#            virtualHosts."default" = {
#                forceSSL = true;
#                default = true;
#            };
#    }
#
#let
#    cfg = config.services.nginx;
#in
#{
#    options.services.nginx = {
#        enable = mkEnableOption "nginx reverse proxy";
#        virtualHosts = lib.mkOption {
#            type = lib.types.attrsOf (lib.types.submodule {
#
#                });
#            default = {};
#            description = "nginx virtual hosts";
#        };
#    };
#
#    config = lib.mkIf cfg.enable {
#            services.nginx = {
#                enable = true;
#                recommendedOptimizations = true;
#                recommendedGzipSettings = true;
#                recommendedProxySettings = true;
#                recommendedTlsSettings = true;
#
#                virtualHosts = lib.mapAttrs (_: vhost: {
#                        forceSSL = true;
#                        enableACME = false;
#                        sslCertificate = "/etc/ssl/certs/localhost.crt";
#                        sslCertificateKey = "/etc/ssl/private/localhost.key";
#                        locations."/" = {
#                            proxyPass = "http://localhost:2015";
#                            extraConfig = ''
#                                proxy_set_header Host $host;
#                                proxy_set_header X-Real-IP $remote_addr;
#                                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#                                proxy_set_header X-Forwarded-Proto $scheme;
#                                '';
#                        };
#
#                    })
#        }
#
## ------------------------
#        services.nginx = {
#            enable = true;
#            recommendedOptimizations = true;
#            recommendedGzipSettings = true;
#            recommendedProxySettings = true;
#            recommendedTlsSettings = true;
#
#            virtualHosts."192.168.1.160" = {
#
#                "default" = {
#                    forceSSL = true;
#                    default = true;
#                };
#                "UnifiController"
#
#                enableACME = false;
#                sslCertificate = "/etc/ssl/certs/localhost.crt";
#                locations."/" = {
#                    proxyPass = "http://localhost:2015";
#                    extraConfig = ''
#                        proxy_set_header Host $host;
#                        proxy_set_header X-Real-IP $remote_addr;
#                        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#                        proxy_set_header X-Forwarded-Proto $scheme;
#                        '';
#                };
#            };
#            }
#    }
#{
#    imports = [
#    ];
#
#    services.nginx = {
#        enable = true;
#        virtualHosts = {
#            "localhost" = {
#                forceSSL = true;
#                enableACME = false;
#                sslCertificate = "/etc/ssl/certs/localhost.crt";
#                locations."/" = {
#                    proxyPass = "http://localhost:2015";
#                    extraConfig = ''
#                        proxy_set_header Host $host;
#                        proxy_set_header X-Real-IP $remote_addr;
#                        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#                        proxy_set_header X-Forwarded-Proto $scheme;
#                        '';
#                };
#            };
#            };
#    };
##    services.caddy = {
#        #enable = true;
#        #virtualHosts."localhost".extraConfig = ''
#            #respond "Hello, world!"
#        #'';
#        #};
#}
