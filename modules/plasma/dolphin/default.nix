# dolphin module

{ config, options, lib, ... }:

{
  # import option declarations
  imports = [
    ./compactmode.nix
    ./contentdisplay.nix
    ./contextmenu.nix
    ./detailsmode.nix
    ./general.nix
    ./iconmode.nix
    ./panels.nix
  ];

  config = with lib; let

    # function to convert any type to string for dolphinrc file
    anyToString = obj:
      if builtins.isString obj
        then obj
      else if builtins.isBool obj && obj
        then "true"
      else if builtins.isBool obj
        then "false"
      else if builtins.isList obj
        then strings.concatStringsSep "," (lists.forEach obj anyToString)
      else builtins.toString obj;

    # convert attribute set of options to strings
    optionsToStrings = o: strings.concatStrings (mapAttrsToList (name: value: name+"="+(anyToString value)+"\n") o);

  in {
    # create dolphinrc
    xdg.configFile."dolphinrc1".text = ''
      [CompactMode]
      ${optionsToStrings config.plasma.dolphin.compactMode}
      [ContentDisplay]
      ${optionsToStrings config.plasma.dolphin.contentDisplay}
      [ContextMenu]
      ${optionsToStrings config.plasma.dolphin.contextMenu}
      [DetailsMode]
      ${optionsToStrings config.plasma.dolphin.detailsMode}
      [General]
      ${optionsToStrings config.plasma.dolphin.general}
      [IconMode]
      ${optionsToStrings config.plasma.dolphin.iconMode}
      
      [FoldersPanel]
      ${optionsToStrings config.plasma.dolphin.panels.foldersPanel}
      [InformationPanel]
      ${optionsToStrings config.plasma.dolphin.panels.informationPanel}
      [PlacesPanel]
      ${optionsToStrings config.plasma.dolphin.panels.placesPanel}
    '';
  };
}