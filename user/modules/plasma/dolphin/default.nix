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

    # remove defaults from option set
    removeDefaults = o: c: attrsets.filterAttrs (name: val: val != o."${name}".default) c;

    # convert attribute set of options to strings
    optionsToStrings = o: mapAttrsToList (name: val: name+"="+(anyToString val)+"\n") o;

    # create section of dolphinrc file
    # inputs are attribute set of options, and corresponding attribute set of configuration
    makeSection = o: c: strings.concatStrings (optionsToStrings (removeDefaults o c));

    opts = options.plasma.dolphin;
    cfg = config.plasma.dolphin;

  in {
    # create dolphinrc
    xdg.configFile."dolphinrc1".text = ''
      [CompactMode]
      ${makeSection opts.compactMode cfg.compactMode}
      [ContentDisplay]
      ${makeSection opts.contentDisplay cfg.contentDisplay}
      [ContextMenu]
      ${makeSection opts.contextMenu cfg.contextMenu}
      [DetailsMode]
      ${makeSection opts.detailsMode cfg.detailsMode}
      [General]
      ${makeSection opts.general cfg.general}
      [IconMode]
      ${makeSection opts.iconMode cfg.iconMode}
      [FoldersPanel]
      ${makeSection opts.panels.foldersPanel cfg.panels.foldersPanel}
      [InformationPanel]
      ${makeSection opts.panels.informationPanel cfg.panels.informationPanel}
      [PlacesPanel]
      ${makeSection opts.panels.placesPanel cfg.panels.placesPanel}
    '';
  };
}
