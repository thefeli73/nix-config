{
  services.hyprsunset = {
    enable = true;
    settings = {
      profile = [
        {
          time = "06:00";
          identity = true;
        }
        {
          time = "20:00";
          temperature = 5000;
        }
      ];
    };
  };
}
