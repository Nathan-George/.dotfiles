# docker config
{...}: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  # add user to docker group
  users.users."jayden".extraGroups = ["docker"];
}