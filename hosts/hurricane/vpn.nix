{
  networking.wg-quick.interfaces = {
    wg-hurricane = {
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
  };
}
