# dolphin module

{ config, options, lib, ... }:

{
  # import option declarations
  imports = [
    ./general.nix
    ./iconmode.nix
  ];

  config = with lib; let

    # function to convert any type to string
    anyToString = obj:
      if builtins.isString obj
        then obj
      else if builtins.isBool obj && obj
        then "true"
      else if builtins.isBool obj
        then "false"
      else builtins.toString obj;

    # convert attribute set of options to strings
    optionsToStrings = o: strings.concatStrings (mapAttrsToList (name: value: name+"="+(anyToString value)+"\n") o);

  in {
    # create dolphinrc
    xdg.configFile."dolphinrc1".text = ''
      [General]
      ${optionsToStrings config.plasma.dolphin.general}
      [IconMode]
    '';
  };
}