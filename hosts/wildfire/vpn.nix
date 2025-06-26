{
  networking.wg-quick.interfaces = {
    wg-felix = {
      address = ["10.8.0.5/24"];
      dns = ["192.168.0.128"];
      privateKeyFile = "/home/schulze/Nextcloud/secrets/wireguard/Felix-Wildfire-pk";
      peers = [
        {
          publicKey = "a35ZSWhBNzPFkf1RCkg4E7cNnUdGGOr4CsA0EM65H0g=";
          presharedKeyFile = "/home/schulze/Nextcloud/secrets/wireguard/Felix-Wildfire-psk";
          allowedIPs = ["0.0.0.0/0"];
          endpoint = "vpn.schulze.network:51820";
          persistentKeepalive = 25;
        }
      ];
    };

    wg-csb = {
      address = ["192.168.108.27/22" "2a02:9a0:102:108::b/64"];
      privateKeyFile = "/home/schulze/Nextcloud/secrets/wireguard/CSB-Wildfire-pk";
      peers = [
        {
          publicKey = "mTORKHkPcp9+c7VXqVfVseIOQZuJftoUYA0pBe87bDQ=";
          allowedIPs = ["172.18.0.0/16" "192.168.3.0/24" "192.168.108.0/22" "2a02:9a0:102:108::/64" "2a02:9a0:ffff::/48"];
          endpoint = "prod-net-vpn1.infra.brainmill.com:51819";
          persistentKeepalive = 25;
        }
      ];
    };

    #    wg-fg = {
    #      address = ["10.255.11.11/24" "2a02:9a0:300:fff0:11::11/64"];
    #      privateKeyFile = "/home/schulze/Nextcloud/secrets/wireguard/FG-Wildfire-pk";
    #      peers = [
    #        {
    #          publicKey = "h/BUyzXy0Xo4KJKS/U5V4C9rDJT3fWjjiZoy0I7P+H4=";
    #          allowedIPs = ["10.0.0.0/8" "192.168.10.0/24" "2a02:9a0:300:fff0::/48"];
    #          endpoint = "gw1.net.chsfg.se:51831";
    #          persistentKeepalive = 25;
    #        }
    #      ];
    #    };
    #
    #    wg-neanet = {
    #      address = ["192.168.108.25/32" "2a09:2681:204:1::27/64"];
    #      privateKeyFile = "/home/schulze/Nextcloud/secrets/wireguard/Neanet-Wildfire-pk";
    #      peers = [
    #        {
    #          publicKey = "nz1m0crkdarW7y+/p6hKCGncMVHlVhbz0URA6Z71RmM=";
    #          allowedIPs = ["2a09:2681:204:1::/64" "2a09:2681:ffff:13::/64" "2a09:2681:ffff:14::/64" "2a09:2681:ffff:15::/64" "2a09:2681:ffff:16::/64" "172.18.255.0/24"];
    #          endpoint = "prod-jump-got1.infra.brainmill.com:51820";
    #          persistentKeepalive = 25;
    #        }
    #      ];
    #    };
  };
}
