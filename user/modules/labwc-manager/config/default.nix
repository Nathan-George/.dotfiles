# ~/.config/labwc/rc.xml

{ config, lib, ... }:

{
  imports = [
    ./core.nix
    ./placement.nix
    ./theme.nix
    ./windowswitcher.nix
    ./resistance.nix
    ./resize.nix
    ./focus.nix
    ./snapping.nix
    ./desktops.nix
    ./margin.nix
    ./regions.nix
    ./keyboard.nix
  ];

  xdg.configFile."labwc/rctest.xml".text = with lib; let
    
    toStr = obj:
      if isBool obj && obj
        then "yes"
      else if isBool obj
        then "no"
      else toString obj;

    # functions for pretty formatting
    space = n: strings.fixedWidthString n " " "";
    indent = num: s: removeSuffix (space num) (stringAsChars (c:
      if c == "\n"
        then "\n"+(space num)
      else c
    ) s);
    formatList = f: list: removeSuffix "\n" (concatMapStrings f list); 

    cfg = config.programs.labwc.config;

  # too many edge cases to do this programatically
  in ''
    <?xml version="1.0"?>
    <labwc_config>
      <core>
        <decoration>${toStr cfg.core.decoration}</decoration>
        <gap>${toStr cfg.core.gap}</gap>
        <adaptiveSync>${toStr cfg.core.adaptiveSync}</adaptiveSync>
        <allowTearing>${toStr cfg.core.allowTearing}</allowTearing>
        <reuseOutputMode>${toStr cfg.core.reuseOutputMode}</reuseOutputMode>
      </core>
      <placement>
        <policy>${toStr cfg.placement.policy}</policy>
      </placement>
      <theme>
        <name>${toStr cfg.theme.name}</name>
        <cornerRadius>${toStr cfg.theme.cornerRadius}</cornerRadius>
        <keepBorder>${toStr cfg.theme.keepBorder}</keepBorder>
        <dropShadows>${toStr cfg.theme.dropShadows}</dropShadows>
        ${indent 4 (formatList (x: ''
          <font place="${toStr x.place}">
            <name>${toStr x.name}</name>
            <size>${toStr x.size}</size>
            <slant>${toStr x.slant}</slant>
            <weight>${toStr x.weight}</weight>
          </font>
        '') cfg.theme.fonts)}
      </theme>
      <windowSwitcher>
        <show>${toStr cfg.windowSwitcher.show}</show>
        <preview>${toStr cfg.windowSwitcher.preview}</preview>
        <outlines>${toStr cfg.windowSwitcher.outlines}</outlines>
        <allWorkspaces>${toStr cfg.windowSwitcher.allWorkspaces}</allWorkspaces>
        <fields>
          ${indent 6 (formatList (x: ''
            <field>
              <content>${toStr x.content}</content>
              <format>${toStr x.format}</format>
              <width>${toStr x.width}</width>
            </field>
          '') cfg.windowSwitcher.fields)}
        </fields>
      </windowSwitcher>
      <resistance>
        <screenEdgeStrength>${toStr cfg.resistance.screenEdgeStrength}</screenEdgeStrength>
        <windowEdgeStrength>${toStr cfg.resistance.windowEdgeStrength}</windowEdgeStrength>
      </resistance>
      <resize>
        <popupShow>${toStr cfg.resize.popupShow}</popupShow>
      </resize>
      <focus>
        <followMouse>${toStr cfg.focus.followMouse}</followMouse>
        <followMouseRequiresMovement>${toStr cfg.focus.followMouseRequiresMovement}</followMouseRequiresMovement>
        <raiseOnFocus>${toStr cfg.focus.raiseOnFocus}</raiseOnFocus>
      </focus>
      <snapping>
        <range>${toStr cfg.snapping.range}</range>
        <overlay>
          <enabled>${toStr cfg.snapping.overlay.enabled}</enabled>
          <delay>
            <inner>${toStr cfg.snapping.overlay.delay.inner}</inner>
            <outer>${toStr cfg.snapping.overlay.delay.outer}</outer>
          </delay>
        </overlay>
        <topMaximize>${toStr cfg.snapping.topMaximize}</topMaximize>
        <notifyClient>${toStr cfg.snapping.notifyClient}</notifyClient>
      </snapping>
      <desktops>
        <popupTime>${toStr cfg.desktops.popupTime}</popupTime>
        <names>
          ${indent 6 (formatList (x: ''
            <name>${toStr x}</name>
          '') cfg.desktops.names)}
        </names>
        <number>${toStr cfg.desktops.number}</number>
      </desktops>
      <regions>
        ${indent 4 (formatList (x: ''
          <region>
            <name>${toStr x.name}</name>
            <x>${toStr x.x}</x>
            <y>${toStr x.y}</y>
            <height>${toStr x.height}</height>
            <width>${toStr x.width}</width>
          </region>
        '') cfg.regions)}
      </regions>
      <keyboard>
        <numlock>${toStr cfg.keyboard.numlock}</numlock>
        <layoutScope>${toStr cfg.keyboard.layoutScope}</layoutScope>
        <repeatRate>${toStr cfg.keyboard.repeatRate}</repeatRate>
        <repeatDelay>${toStr cfg.keyboard.repeatDelay}</repeatDelay>
        ${indent 4 (formatList (x: ''
          <keybind>
            <key>${toStr x.key}</key>
            <layoutDependant>${toStr x.layoutDependent}</layoutDependant>
            ${indent 2 (formatList (y: ''
              <action>
                <name>${toStr y.name}</name>
                ${indent 2 (formatList (z: ''
                  <${z.name}>${toStr z.value}</${z.name}>
                '') (mapAttrsToList (n: v: {name=n;value=v;}) (filterAttrs (n: v: n != "name") y)))}
              </action>
            '') x.actions)}
          </keybind>
        '') cfg.keyboard.keybinds)}${if cfg.keyboard.default then "<default/>" else ""}
      </keyboard>
      <mouse>
        <doubleClickTime>500</doubleClickTime>
        <scrollFactor>1.0</scrollFactor>
        <context name="Frame">
          <mousebind button="A-Left" action="Press">
            <action name="Focus" />
            <action name="Raise" />
          </mousebind>
          <mousebind button="A-Left" action="Drag">
            <action name="Move" />
          </mousebind>
          <mousebind button="A-Right" action="Press">
            <action name="Focus" />
            <action name="Raise" />
          </mousebind>
          <mousebind button="A-Right" action="Drag">
            <action name="Resize" />
          </mousebind>
        </context>
        <context name="Top">
          <mousebind button="Left" action="Drag">
            <action name="Resize" />
          </mousebind>
        </context>
        <context name="Left">
          <mousebind button="Left" action="Drag">
            <action name="Resize" />
          </mousebind>
        </context>
        <context name="Right">
          <mousebind button="Left" action="Drag">
            <action name="Resize" />
          </mousebind>
        </context>
        <context name="Bottom">
          <mousebind button="Left" action="Drag">
            <action name="Resize" />
          </mousebind>
        </context>
        <context name="TRCorner">
          <mousebind button="Left" action="Drag">
            <action name="Resize" />
          </mousebind>
        </context>
        <context name="BRCorner">
          <mousebind button="Left" action="Drag">
            <action name="Resize" />
          </mousebind>
        </context>
        <context name="TLCorner">
          <mousebind button="Left" action="Drag">
            <action name="Resize" />
          </mousebind>
        </context>
        <context name="BLCorner">
          <mousebind button="Left" action="Drag">
            <action name="Resize" />
          </mousebind>
        </context>
        <context name="TitleBar">
          <mousebind button="Left" action="Press">
            <action name="Focus" />
            <action name="Raise" />
          </mousebind>
          <mousebind button="Right" action="Click">
            <action name="Focus" />
            <action name="Raise" />
          </mousebind>
          <mousebind direction="Up" action="Scroll">
            <action name="Unshade" />
            <action name="Focus" />
          </mousebind>
          <mousebind direction="Down" action="Scroll">
            <action name="Unfocus" />
            <action name="Shade" />
          </mousebind>
        </context>
        <context name="Title">
          <mousebind button="Left" action="Drag">
            <action name="Move" />
          </mousebind>
          <mousebind button="Left" action="DoubleClick">
            <action name="ToggleMaximize" />
          </mousebind>
          <mousebind button="Right" action="Click">
            <action name="ShowMenu" menu="client-menu" />
          </mousebind>
        </context>
        <context name="Maximize">
          <mousebind button="Left" action="Click">
            <action name="ToggleMaximize" />
          </mousebind>
          <mousebind button="Right" action="Click">
            <action name="ToggleMaximize" direction="horizontal" />
          </mousebind>
          <mousebind button="Middle" action="Click">
            <action name="ToggleMaximize" direction="vertical" />
          </mousebind>
        </context>
        <context name="WindowMenu">
          <mousebind button="Left" action="Click">
            <action name="ShowMenu" menu="client-menu" />
          </mousebind>
          <mousebind button="Right" action="Click">
            <action name="ShowMenu" menu="client-menu" />
          </mousebind>
        </context>
        <context name="Iconify">
          <mousebind button="Left" action="Click">
            <action name="Iconify" />
          </mousebind>
        </context>
        <context name="Close">
          <mousebind button="Left" action="Click">
            <action name="Close" />
          </mousebind>
        </context>
        <context name="Client">
          <mousebind button="Left" action="Press">
            <action name="Focus" />
            <action name="Raise" />
          </mousebind>
          <mousebind button="Middle" action="Press">
            <action name="Focus" />
            <action name="Raise" />
          </mousebind>
          <mousebind button="Right" action="Press">
            <action name="Focus" />
            <action name="Raise" />
          </mousebind>
        </context>
        <context name="Root">
          <mousebind button="Left" action="Press">
            <action name="ShowMenu" menu="root-menu" />
          </mousebind>
          <mousebind button="Right" action="Press">
            <action name="ShowMenu" menu="root-menu" />
          </mousebind>
          <mousebind button="Middle" action="Press">
            <action name="ShowMenu" menu="root-menu" />
          </mousebind>
          <mousebind direction="Up" action="Scroll">
            <action name="GoToDesktop" to="left" wrap="yes" />
          </mousebind>
          <mousebind direction="Down" action="Scroll">
            <action name="GoToDesktop" to="right" wrap="yes" />
          </mousebind>
        </context>
      </mouse>
      <touch deviceName="" mapToOutput="" />
      <tablet mapToOutput="" rotate="0" mouseEmulation="no">
        <area top="0.0" left="0.0" width="0.0" height="0.0" />
        <map button="Tip" to="Left" />
        <map button="Stylus" to="Right" />
        <map button="Stylus2" to="Middle" />
      </tablet>
      <libinput>
        <device category="default">
          <naturalScroll></naturalScroll>
          <leftHanded></leftHanded>
          <pointerSpeed></pointerSpeed>
          <accelProfile></accelProfile>
          <tap>yes</tap>
          <tapButtonMap></tapButtonMap>
          <tapAndDrag></tapAndDrag>
          <dragLock></dragLock>
          <middleEmulation></middleEmulation>
          <disableWhileTyping></disableWhileTyping>
          <clickMethod></clickMethod>
          <sendEventsMode></sendEventsMode>
          <calibrationMatrix></calibrationMatrix>
        </device>
      </libinput>
      <menu>
        <ignoreButtonReleasePeriod>250</ignoreButtonReleasePeriod>
      </menu>
      <magnifier>
        <width>400</width>
        <height>400</height>
        <initScale>2.0</initScale>
        <increment>0.2</increment>
        <useFilter>true</useFilter>
      </magnifier>
    </labwc_config>
  '';
}

#     <?xml version="1.0"?>
#     <labwc_config>
#       <core>
#         <decoration>${cfg.core.decoration}</decoration>
#         <gap>${cfg.core.gap}</gap>
#         <adaptiveSync>${cfg.core.adaptiveSync}</adaptiveSync>
#         <allowTearing>${cfg.core.allowTearing}</allowTearing>
#         <reuseOutputMode>${reuseOutputMode}</reuseOutputMode>
#       </core>
#       <placement>
#         <policy>${cfg.placement.policy}</policy>
#       </placement>
#       <theme>
#         <name></name>
#         <cornerRadius>8</cornerRadius>
#         <keepBorder>yes</keepBorder>
#         <dropShadows>no</dropShadows>
#         <font place="ActiveWindow">
#           <name>sans</name>
#           <size>10</size>
#           <slant>normal</slant>
#           <weight>normal</weight>
#         </font>
#         <font place="InactiveWindow">
#           <name>sans</name>
#           <size>10</size>
#           <slant>normal</slant>
#           <weight>normal</weight>
#         </font>
#         <font place="MenuItem">
#           <name>sans</name>
#           <size>10</size>
#           <slant>normal</slant>
#           <weight>normal</weight>
#         </font>
#         <font place="OnScreenDisplay">
#           <name>sans</name>
#           <size>10</size>
#           <slant>normal</slant>
#           <weight>normal</weight>
#         </font>
#       </theme>
#       <windowSwitcher show="yes" preview="yes" outlines="yes" allWorkspaces="no">
#         <fields>
#           <field content="type" width="25%" />
#           <field content="trimmed_identifier" width="25%" />
#           <field content="title" width="50%" />
#         </fields>
#       </windowSwitcher>
#       <resistance>
#         <screenEdgeStrength>20</screenEdgeStrength>
#         <windowEdgeStrength>20</windowEdgeStrength>
#       </resistance>
#       <resize popupShow="Never" />
#       <focus>
#         <followMouse>no</followMouse>
#         <followMouseRequiresMovement>yes</followMouseRequiresMovement>
#         <raiseOnFocus>no</raiseOnFocus>
#       </focus>
#       <snapping>
#         <range>1</range>
#         <overlay enabled="yes">
#           <delay inner="500" outer="500" />
#         </overlay>
#         <topMaximize>yes</topMaximize>
#         <notifyClient>always</notifyClient>
#       </snapping>
#       <desktops>
#         <popupTime>1000</popupTime>
#         <names>
#           <name>Default</name>
#         </names>
#       </desktops>
#       <keyboard>
#         <numlock>on</numlock>
#         <layoutScope>global</layoutScope>
#         <repeatRate>25</repeatRate>
#         <repeatDelay>600</repeatDelay>
#         <keybind key="A-Tab">
#           <action name="NextWindow" />
#         </keybind>
#         <keybind key="W-Return">
#           <action name="Execute" command="alacritty" />
#         </keybind>
#         <keybind key="A-F3">
#           <action name="Execute" command="bemenu-run" />
#         </keybind>
#         <keybind key="A-F4">
#           <action name="Close" />
#         </keybind>
#         <keybind key="W-a">
#           <action name="ToggleMaximize" />
#         </keybind>
#         <keybind key="A-Left">
#           <action name="MoveToEdge" direction="left" />
#         </keybind>
#         <keybind key="A-Right">
#           <action name="MoveToEdge" direction="right" />
#         </keybind>
#         <keybind key="A-Up">
#           <action name="MoveToEdge" direction="up" />
#         </keybind>
#         <keybind key="A-Down">
#           <action name="MoveToEdge" direction="down" />
#         </keybind>
#         <keybind key="W-Left">
#           <action name="SnapToEdge" direction="left" />
#         </keybind>
#         <keybind key="W-Right">
#           <action name="SnapToEdge" direction="right" />
#         </keybind>
#         <keybind key="W-Up">
#           <action name="SnapToEdge" direction="up" />
#         </keybind>
#         <keybind key="W-Down">
#           <action name="SnapToEdge" direction="down" />
#         </keybind>
#         <keybind key="A-Space">
#           <action name="ShowMenu" menu="client-menu" />
#         </keybind>
#         <keybind key="XF86_AudioLowerVolume">
#           <action name="Execute" command="amixer sset Master 5%-" />
#         </keybind>
#         <keybind key="XF86_AudioRaiseVolume">
#           <action name="Execute" command="amixer sset Master 5%+" />
#         </keybind>
#         <keybind key="XF86_AudioMute">
#           <action name="Execute" command="amixer sset Master toggle" />
#         </keybind>
#         <keybind key="XF86_MonBrightnessUp">
#           <action name="Execute" command="brightnessctl set +10%" />
#         </keybind>
#         <keybind key="XF86_MonBrightnessDown">
#           <action name="Execute" command="brightnessctl set 10%-" />
#         </keybind>
#       </keyboard>
#       <mouse>
#         <doubleClickTime>500</doubleClickTime>
#         <scrollFactor>1.0</scrollFactor>
#         <context name="Frame">
#           <mousebind button="A-Left" action="Press">
#             <action name="Focus" />
#             <action name="Raise" />
#           </mousebind>
#           <mousebind button="A-Left" action="Drag">
#             <action name="Move" />
#           </mousebind>
#           <mousebind button="A-Right" action="Press">
#             <action name="Focus" />
#             <action name="Raise" />
#           </mousebind>
#           <mousebind button="A-Right" action="Drag">
#             <action name="Resize" />
#           </mousebind>
#         </context>
#         <context name="Top">
#           <mousebind button="Left" action="Drag">
#             <action name="Resize" />
#           </mousebind>
#         </context>
#         <context name="Left">
#           <mousebind button="Left" action="Drag">
#             <action name="Resize" />
#           </mousebind>
#         </context>
#         <context name="Right">
#           <mousebind button="Left" action="Drag">
#             <action name="Resize" />
#           </mousebind>
#         </context>
#         <context name="Bottom">
#           <mousebind button="Left" action="Drag">
#             <action name="Resize" />
#           </mousebind>
#         </context>
#         <context name="TRCorner">
#           <mousebind button="Left" action="Drag">
#             <action name="Resize" />
#           </mousebind>
#         </context>
#         <context name="BRCorner">
#           <mousebind button="Left" action="Drag">
#             <action name="Resize" />
#           </mousebind>
#         </context>
#         <context name="TLCorner">
#           <mousebind button="Left" action="Drag">
#             <action name="Resize" />
#           </mousebind>
#         </context>
#         <context name="BLCorner">
#           <mousebind button="Left" action="Drag">
#             <action name="Resize" />
#           </mousebind>
#         </context>
#         <context name="TitleBar">
#           <mousebind button="Left" action="Press">
#             <action name="Focus" />
#             <action name="Raise" />
#           </mousebind>
#           <mousebind button="Right" action="Click">
#             <action name="Focus" />
#             <action name="Raise" />
#           </mousebind>
#           <mousebind direction="Up" action="Scroll">
#             <action name="Unshade" />
#             <action name="Focus" />
#           </mousebind>
#           <mousebind direction="Down" action="Scroll">
#             <action name="Unfocus" />
#             <action name="Shade" />
#           </mousebind>
#         </context>
#         <context name="Title">
#           <mousebind button="Left" action="Drag">
#             <action name="Move" />
#           </mousebind>
#           <mousebind button="Left" action="DoubleClick">
#             <action name="ToggleMaximize" />
#           </mousebind>
#           <mousebind button="Right" action="Click">
#             <action name="ShowMenu" menu="client-menu" />
#           </mousebind>
#         </context>
#         <context name="Maximize">
#           <mousebind button="Left" action="Click">
#             <action name="ToggleMaximize" />
#           </mousebind>
#           <mousebind button="Right" action="Click">
#             <action name="ToggleMaximize" direction="horizontal" />
#           </mousebind>
#           <mousebind button="Middle" action="Click">
#             <action name="ToggleMaximize" direction="vertical" />
#           </mousebind>
#         </context>
#         <context name="WindowMenu">
#           <mousebind button="Left" action="Click">
#             <action name="ShowMenu" menu="client-menu" />
#           </mousebind>
#           <mousebind button="Right" action="Click">
#             <action name="ShowMenu" menu="client-menu" />
#           </mousebind>
#         </context>
#         <context name="Iconify">
#           <mousebind button="Left" action="Click">
#             <action name="Iconify" />
#           </mousebind>
#         </context>
#         <context name="Close">
#           <mousebind button="Left" action="Click">
#             <action name="Close" />
#           </mousebind>
#         </context>
#         <context name="Client">
#           <mousebind button="Left" action="Press">
#             <action name="Focus" />
#             <action name="Raise" />
#           </mousebind>
#           <mousebind button="Middle" action="Press">
#             <action name="Focus" />
#             <action name="Raise" />
#           </mousebind>
#           <mousebind button="Right" action="Press">
#             <action name="Focus" />
#             <action name="Raise" />
#           </mousebind>
#         </context>
#         <context name="Root">
#           <mousebind button="Left" action="Press">
#             <action name="ShowMenu" menu="root-menu" />
#           </mousebind>
#           <mousebind button="Right" action="Press">
#             <action name="ShowMenu" menu="root-menu" />
#           </mousebind>
#           <mousebind button="Middle" action="Press">
#             <action name="ShowMenu" menu="root-menu" />
#           </mousebind>
#           <mousebind direction="Up" action="Scroll">
#             <action name="GoToDesktop" to="left" wrap="yes" />
#           </mousebind>
#           <mousebind direction="Down" action="Scroll">
#             <action name="GoToDesktop" to="right" wrap="yes" />
#           </mousebind>
#         </context>
#       </mouse>
#       <touch deviceName="" mapToOutput="" />
#       <tablet mapToOutput="" rotate="0" mouseEmulation="no">
#         <area top="0.0" left="0.0" width="0.0" height="0.0" />
#         <map button="Tip" to="Left" />
#         <map button="Stylus" to="Right" />
#         <map button="Stylus2" to="Middle" />
#       </tablet>
#       <libinput>
#         <device category="default">
#           <naturalScroll></naturalScroll>
#           <leftHanded></leftHanded>
#           <pointerSpeed></pointerSpeed>
#           <accelProfile></accelProfile>
#           <tap>yes</tap>
#           <tapButtonMap></tapButtonMap>
#           <tapAndDrag></tapAndDrag>
#           <dragLock></dragLock>
#           <middleEmulation></middleEmulation>
#           <disableWhileTyping></disableWhileTyping>
#           <clickMethod></clickMethod>
#           <sendEventsMode></sendEventsMode>
#           <calibrationMatrix></calibrationMatrix>
#         </device>
#       </libinput>
#       <menu>
#         <ignoreButtonReleasePeriod>250</ignoreButtonReleasePeriod>
#       </menu>
#       <magnifier>
#         <width>400</width>
#         <height>400</height>
#         <initScale>2.0</initScale>
#         <increment>0.2</increment>
#         <useFilter>true</useFilter>
#       </magnifier>
#     </labwc_config>