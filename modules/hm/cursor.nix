{pkgs, ...}: {
  home.pointerCursor = {
    enable = true;
    size = 32;
    #name = "capitaine-cursors-themed";
    #package = pkgs.capitaine-cursors-themed;
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
  };
}
