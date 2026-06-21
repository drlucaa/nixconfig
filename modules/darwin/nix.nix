{
  username,
  ...
}:
{
  determinateNix = {
    enable = true;

    customSettings = {
      download-buffer-size = 524000000;

      trusted-users = [
        "root"
        "@admin"
        username
      ];
    };
  };
}
