{
  networking.wg-quick.interfaces = {
    wg-wildfire = {
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
  };
}
