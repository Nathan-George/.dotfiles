# dolphin config

{ config, ... }:

{
  plasma.dolphin = {

    general = {
      BrowseThroughArchives = true;
      RememberOpenedTabs = false;
      ShowSpaceInfo = false;
      ShowZoomSlider = false;
    };

    compactMode = {
      PreviewSize = config.plasma.constants.KIconLoader.StdSizes.Small;
    };
    
    detailsMode = {
      PreviewSize = config.plasma.constants.KIconLoader.StdSizes.Small;
    };

    contentDisplay = {
      UseShortRelativeDates = false;
    };

    contextMenu = {
      ShowAddToPlaces = false;
      ShowCopyToOtherSplitView = false;
      ShowMoveToOtherSplitView = false;
      ShowOpenInNewTab = false;
      ShowOpenTerminal = false;
      ShowSortBy = false;
      ShowViewMode = false;
    };

  };
}
