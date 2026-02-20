{
  pkgs,
  inputs,
  ...
}: {
  programs.git = {
    enable = true;
    settings.user.name = "KBucha";
    settings.user.email = "KBucha@datamola.com";
  };
}
