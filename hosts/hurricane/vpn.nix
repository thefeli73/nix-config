{
  networking.wg-quick.interfaces = {
    wg-felix = {
      address = ["10.8.0.4/24"];
      dns = ["192.168.0.128"];
      privateKeyFile = "/home/schulze/Nextcloud/secrets/wireguard/Felix-Hurricane-pk";

      peers = [
        {
          publicKey = "a35ZSWhBNzPFkf1RCkg4E7cNnUdGGOr4CsA0EM65H0g=";
          presharedKeyFile = "/home/schulze/Nextcloud/secrets/wireguard/Felix-Hurricane-psk";
          allowedIPs = ["0.0.0.0/0"];
          endpoint = "vpn.schulze.network:51820";
          persistentKeepalive = 25;
        }
      ];
    };

    wg-csb = {
      address = ["192.168.108.17/22" "2a02:9a0:102:108::17/64"];
      privateKeyFile = "/home/schulze/Nextcloud/secrets/wireguard/CSB-Hurricane-pk";
      peers = [
        {
          publicKey = "mTORKHkPcp9+c7VXqVfVseIOQZuJftoUYA0pBe87bDQ=";
          allowedIPs = ["95.80.0.0/18" "45.134.56.0/22" "172.18.0.0/16" "192.168.3.0/24" "192.168.108.0/22" "2a02:9a0::/32"];
          endpoint = "prod-net-vpn1.infra.brainmill.com:51819";
          persistentKeepalive = 25;
        }
      ];
    };
    wg-fg = {
      address = ["10.255.11.11/24" "2a02:9a0:300:fff0:11::11/64"];
      privateKeyFile = "/home/schulze/Nextcloud/secrets/wireguard/FG-Hurricane-pk";
      peers = [
        {
          publicKey = "h/BUyzXy0Xo4KJKS/U5V4C9rDJT3fWjjiZoy0I7P+H4=";
          allowedIPs = ["10.0.0.0/8" "192.168.10.0/24" "2a02:9a0:300:fff0::/48"];
          endpoint = "gw1.net.chsfg.se:51831";
          persistentKeepalive = 25;
        }
      ];
    };

    wg-neanet = {
      address = ["192.168.108.25/32" "2a09:2681:204:1::27/64"];
      privateKeyFile = "/home/schulze/Nextcloud/secrets/wireguard/Neanet-Hurricane-pk";
      peers = [
        {
          publicKey = "nz1m0crkdarW7y+/p6hKCGncMVHlVhbz0URA6Z71RmM=";
          allowedIPs = ["185.239.220.0/22" "172.18.255.0/24" "2a09:2681::/32"];
          endpoint = "prod-jump-got1.infra.brainmill.com:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
