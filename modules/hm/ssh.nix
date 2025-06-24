{
  programs.ssh = {
    enable = true;
    serverAliveInterval = 60;
    serverAliveCountMax = 2;

    matchBlocks = {
      "d10.csb.brainmill.com" = {
        forwardAgent = true;
        port = 22;
      };
      "prod-admin-jump1.infra.csbnet.se" = {
        forwardAgent = true;
        port = 22;
      };
      "prod-jump-got1.infra.brainmill.com" = {
        forwardAgent = true;
        port = 22;
      };
      "gw1.net.chsfg.se" = {
        forwardAgent = true;
        hostname = "2a02:9a0:fffe:4::3";
      };
      "gw2.net.chsfg.se" = {
        forwardAgent = true;
        hostname = "2a02:9a0:fffe:4::5";
      };
      "cv11-stor-gw.net.chsfg.se" = {
        proxyCommand = "ssh prod-admin-jump1.infra.csbnet.se /bin/nc %h 22";
        hostname = "176.10.244.136";
        user = "root";
        port = 8822;
      };
      "tp2-core1.net.chsfg.se" = {
        hostname = "192.168.10.52";
        user = "nvg";
      };
      "gw-shg9d-ctk.net.chsfg.se" = {
        hostname = "83.218.70.146";
        user = "admin";
      };
      "lp5-core1.net.chsfg.se" = {
        hostname = "192.168.10.51";
        user = "nvg";
      };
      "sw-fys-kt11-serv1.net.chsfg.se" = {
        hostname = "10.2.13.10";
      };
      "sw-fys-kt11-kansli1.net.chsfg.se" = {
        hostname = "10.2.13.11";
      };
      "sw-fys-kt11-kansli2.net.chsfg.se" = {
        hostname = "10.2.13.12";
      };
      "sw-fys-kt11-reception1.net.chsfg.se" = {
        hostname = "10.2.13.13";
      };
      "sw-fys-kt11-reception2.net.chsfg.se" = {
        hostname = "10.2.13.14";
      };
      "sw-fys-gg39-kom.net.chsfg.se" = {
        hostname = "10.1.13.10";
      };
      "sw-fys-gg39-skap.net.chsfg.se" = {
        hostname = "10.1.13.11";
      };
      "sw-fys-ev1.net.chsfg.se" = {
        hostname = "10.62.13.10";
      };
      "192.168.10.20" = {
        hostname = "192.168.10.20";
        user = "manager";
      };
      "192.168.10.50" = {
        hostname = "192.168.10.50";
      };
    };
  };
}
