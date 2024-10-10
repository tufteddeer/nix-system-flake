{ config, pkgs, ... }:
{

  services.grafana = {
    enable = true;
    settings.server.http_port = 6000;
  };

  services.prometheus = {
    enable = true;
    port = 9090;
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = [ "localhost:9100" ];
          }
        ];
      }

      {
        job_name = "uptime-kuma";
        static_configs = [
          {
            targets = [ "localhost:${toString config.services.uptime-kuma.settings.PORT}" ];
          }
        ];
        metrics_path = "/metrics";
        basic_auth = {
          username = "admin";
          password_file = config.sops.secrets.kuma-admin.path;
        };
      }
      {
        job_name = "systemd";
        static_configs = [
          {
            targets = [ "localhost:9558" ];
          }
        ];
      }

    ];


    exporters.node = {
      enable = true;
      enabledCollectors = [
        "systemd"
        "logind"
      ];
    };
    exporters.systemd = {
      enable = true;
    };
  };

  services.uptime-kuma = {
    enable = true;
    settings = {
      HOST = "0.0.0.0";
      PORT = "4000";
    };
  };
}
