{
  network.description = "Pursuit";
  network.enableRollback = false;

  pursuit = { config, pkgs, ... }: {
    imports = [ ./pursuit/module.nix ];

    services = {
      nginx = {
        enable = true;
        recommendedTlsSettings = true;
        recommendedOptimisation = true;
        recommendedGzipSettings = true;
        recommendedProxySettings = true;
        virtualHosts = {
          "pursuit.purescript.org" = {
            forceSSL = true;
            enableACME = true;
            default = true;
            locations."/" = { proxyPass = "http://localhost:3000"; };
          };
        };
      };

      pursuit = {
        enable = true;
        rootUrl = "https://pursuit.purescript.org";
        github_client_id = "XXXXXXXXXXXXXXXXXXXX";
        github_client_secret = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        client_session = "J8kehn1F96uULLXtORfrbSG12FawDSMi83WgxzQbB1z7zp8uFLchkm4fPWpHyiV7UvmeZHGoI18VTpV8rajYCd8ljF/PC35bCOW/lveBs6qixy94Uwy147BtmfcuwM6t";
      };
    };

    security.acme.certs."pursuit.purescript.org" = {
      email = "admin@purescript.org";
      postRun = "systemctl reload nginx";
    };

    networking.firewall.allowedTCPPorts = [ 443 80 ];
  };
}
