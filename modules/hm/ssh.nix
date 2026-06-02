{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        ServerAliveInterval = 60;
        ServerAliveCountMax = 2;
        SendEnv = ["TERM"];
        SetEnv = {
          TERM = "xterm-256color"; # Fix ghostty issue
        };
      };
      "d10.csb.brainmill.com" = {
        ForwardAgent = true;
      };
      "prod-admin-jump1.infra.csbnet.se" = {
        ForwardAgent = true;
      };
      "prod-jump-got1.infra.brainmill.com" = {
        ForwardAgent = true;
      };
      "gw1.net.chsfg.se" = {
        ForwardAgent = true;
      };
      "gw2.net.chsfg.se" = {
        ForwardAgent = true;
      };
      "cv11-stor-gw.net.chsfg.se" = {
        ProxyCommand = "ssh prod-admin-jump1.infra.csbnet.se /bin/nc %h 22";
        HostName = "176.10.244.136";
        User = "root";
        Port = 8822;
      };
      "tp2-core1.net.chsfg.se" = {
        HostName = "192.168.10.52";
        User = "nvg";
      };
      "gw-shg9d-ctk.net.chsfg.se" = {
        HostName = "83.218.70.146";
        User = "admin";
      };
      "lp5-core1.net.chsfg.se" = {
        HostName = "192.168.10.51";
        User = "nvg";
      };
      "sw-fys-kt11-serv1.net.chsfg.se" = {
        HostName = "10.2.13.10";
      };
      "sw-fys-kt11-kansli1.net.chsfg.se" = {
        HostName = "10.2.13.11";
      };
      "sw-fys-kt11-kansli2.net.chsfg.se" = {
        HostName = "10.2.13.12";
      };
      "sw-fys-kt11-reception1.net.chsfg.se" = {
        HostName = "10.2.13.13";
      };
      "sw-fys-kt11-reception2.net.chsfg.se" = {
        HostName = "10.2.13.14";
      };
      "sw-fys-gg39-kom.net.chsfg.se" = {
        HostName = "10.1.13.10";
      };
      "sw-fys-gg39-skap.net.chsfg.se" = {
        HostName = "10.1.13.11";
      };
      "sw-fys-ev1.net.chsfg.se" = {
        HostName = "10.62.13.10";
      };
      "192.168.10.20" = {
        HostName = "192.168.10.20";
        User = "manager";
      };
      "192.168.10.50" = {
        HostName = "192.168.10.50";
      };
    };
  };
}
