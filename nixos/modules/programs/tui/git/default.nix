{
  pkgs,
  inputs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "KBucha";
    userEmail = "KBucha@datamola.com$";
  };
}
