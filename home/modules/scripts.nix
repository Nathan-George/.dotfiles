# scripts used in config
{lib, ...}:
with lib; {
  options.scripts = mkOption {
    type = types.attrsOf types.path;
    default = {};
    description = "A collection of common scripts";
  };
}
