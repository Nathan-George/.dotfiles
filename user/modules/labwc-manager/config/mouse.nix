# # https://labwc.github.io/labwc-config.5.html#mouse

# { lib, ... }:

# {
#   options.programs.labwc.config.mouse = with lib; {
#     doubleClickTime = mkOption {
#       type = types.int;
#       default = 500;
#       description = "Set double click time in milliseconds. Default is 500.";
#     };
#     scrollFactor = mkOption {
#       type = types.float;
#       default = 1.0;
#       description = "Set scroll factor. Default is 1.0.";
#     };
#     mousebinds = mkOption {
#       type = types.submodule {
#         options = let
#           mouseContextSubmodule = types.listOf (types.submodule {
#             options = {
#               button = mkOption {
#                 type = types.enum [ "" "Left" "Middle" "Right" "Side" "Extra" "Forward" "Back" "Task" ]; 
#                 default = "";
#               };
#               directon = mkOption {
#                 type = types.enum [ "" "Up" "Down" "Left" "Right" ];
#                 default = "";
#               };
#               action = mkOption {
#                 type = types.enum [ "" "Press" "Release" "Click" "DoubleClicl" "Drag" "Scroll" ];
#                 default = "";
#               };
#               actions = mkOption {
#                 type = types.listOf (types.addCheck (types.attrsOf types.str) (x: hasAttr "name" x));
#                 default = [];
#               };
#             };
#           });
#         in {
#           TitleBar = mkOption { type = mouseContextSubmodule; };
#           Title = mkOption { type = mouseContextSubmodule; };
#           WindowMenu = mkOption { type = mouseContextSubmodule; };
#           Iconify = mkOption { type = mouseContextSubmodule; };
#           Maximize = mkOption { type = mouseContextSubmodule; };
#           Close = mkOption { type = mouseContextSubmodule; };
#           Top = mkOption { type = mouseContextSubmodule; };
#           Bottom = mkOption { type = mouseContextSubmodule; };
#           Left = mkOption { type = mouseContextSubmodule; };
#           Right = mkOption { type = mouseContextSubmodule; };
#           TRCorner = mkOption { type = mouseContextSubmodule; };
#           TLCorner = mkOption { type = mouseContextSubmodule; };
#           BLCorner = mkOption { type = mouseContextSubmodule; };
#           BRCorner = mkOption { type = mouseContextSubmodule; };
#           Client = mkOption { type = mouseContextSubmodule; };
#           Frame = mkOption { type = mouseContextSubmodule; };
#           Desktop = mkOption { type = mouseContextSubmodule; };
#           Root = mkOption { type = mouseContextSubmodule; };
#           All = mkOption { type = mouseContextSubmodule; };
#         };
#       };
#       default = {
#         TitleBar = [
#           { button="Left"; action="Press"; actions=[
#             { name="Focus"; }
#             { name="Raise"; }
#           ];}
#           { button="Right"; action="Click"; actions = [
#             { name="Focus"; }
#             { name="Raise"; }
#           ];}
#           { direction="Up"; action="Scroll"; actions = [
#             { name="Unshade"; }
#             { name="Focus"; }
#           ];}
#           { direction="Down"; action="Scroll"; actions = [
#             { name="Unshade"; }
#             { name="Focus"; }
#           ];}
#         ];
#         Title = [
#           { button="Left"; action="}
#         ];
#         WindowMenu = [];
#         Iconify = [];
#         Maximize = [];
#         Close = [];
#         Top = [];
#         Bottom = [];
#         Left = [];
#         Right = [];
#         TRCorner = [];
#         TLCorner = [];
#         BLCorner = [];
#         BRCorner = [];
#         Client = [];
#         Frame = [];
#         Desktop = [];
#         Root = [];
#         All = [];
#       };
      
#     };
#   };
# }
