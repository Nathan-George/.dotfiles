# wireshark config
{...}: {
  # enable wireshark
  programs.wireshark.enable = true;

  # add user to wireshark group
  users.users."jayden".extraGroups = ["wireshark"];
}
