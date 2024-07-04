# ~/.config/labwc/menu.xml

{ config, lib, ... }:

with lib; {

  options.programs.labwc.menus = mkOption {
    type = types.attrsOf (types.listOf );
    default = {};
    description = "Set environment variables";
  };

  config = mkIf (config.programs.labwc.enable) {
    xdg.configFile."labwc/menu.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <openbox_menu>
        <menu id="client-menu">
          <item label="Minimize">
            <action name="Iconify" />
          </item>
          <item label="Maximize">
            <action name="ToggleMaximize" />
          </item>
          <item label="Fullscreen">
            <action name="ToggleFullscreen" />
          </item>
          <item label="Roll up/down">
            <action name="ToggleShade" />
          </item>
          <item label="Decorations">
            <action name="ToggleDecorations" />
          </item>
          <item label="Always on Top">
            <action name="ToggleAlwaysOnTop" />
          </item>
          <menu id="workspaces" label="Workspace">
            <item label="Move left">
              <action name="SendToDesktop" to="left" />
            </item>
            <item label="Move right">
              <action name="SendToDesktop" to="right" />
            </item>
            <separator />
            <item label="Always on Visible Workspace">
              <action name="ToggleOmnipresent" />
            </item>
          </menu>
          <item label="Close">
            <action name="Close" />
          </item>
        </menu>
        <menu id="root-menu">
          <item label="Web browser">
            <action name="Execute" command="firefox" />
          </item>
          <item label="Terminal">
            <action name="Execute" command="alacritty" />
          </item>
          <item label="Reconfigure">
            <action name="Reconfigure" />
          </item>
          <item label="Exit">
            <action name="Exit" />
          </item>
          <item label="Poweroff">
            <action name="Execute" command="systemctl -i poweroff" />
          </item>
        </menu>
        <menu id="some-custom-menu">
          <item label="Reconfigure">
            <action name="Reconfigure" />
          </item>
          <item label="Exit">
            <action name="Exit" />
          </item>
        </menu>
      </openbox_menu>
    '';
  };
  
}
