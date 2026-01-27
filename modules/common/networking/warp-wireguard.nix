{ config, ... }:

{
  networking.wg-quick = {
    interfaces = {
      warp = {
        privateKeyFile = config.sops.secrets.wgcf_privatekey.path;

        address = [
          "172.16.0.2/32"
          "2606:4700:110:8e41:c8ab:3253:e697:f80f/128"
        ];

        dns = [
          "1.1.1.1"
          "1.0.0.1"
          "2606:4700:4700::1111"
          "2606:4700:4700::1001"
        ];

        mtu = 1500;

        peers = [
          {
            publicKey = "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=";
            allowedIPs = [
              "0.0.0.0/0"
              "::/0"
            ];
            endpoint = "engage.cloudflareclient.com:2408";
          }
        ];
      };
    };
  };
}