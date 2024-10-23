# lf config
{
  config,
  lib,
  pkgs,
  ...
}: {
  # install font awesome
  home.packages = [pkgs.font-awesome];

  # lfcd wrapper script
  home.shellAliases.lf = ". ${pkgs.writeShellScript "lf_wrapper" ''
    # open lf, then cd to the last directory upon close
    cd "$(command lf -print-last-dir "$@")"
  ''}";

  # make lf default file explorer
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "lf.desktop";
    };
  };

  # config
  programs.lf = {
    enable = true;

    settings = {
      preview = true;
      dirfirst = false;
      drawbox = true;
      icons = true;
      ignorecase = true;
      wrapscroll = true;
      filesep = " ";
    };

    commands = {
      zip = "%${pkgs.zip}/bin/zip -rj \"$f.zip\" \"$f\"";
      unzip = ''
        ''${{
                case "$f" in
                  *.zip) ${pkgs.unzip}/bin/unzip "$f" ;;
                  *.tar.gz|*.tgz) tar -xzvf "$f" ;;
                  *.tar.bz2) tar -xjvf "$f" ;;
                  *.tar) tar -xvf "$f" ;;
                  *) echo "Unsupported archive format" ;;
                esac
              }}'';
      open = ''
        ''${{
                case $(${pkgs.file}/bin/file --mime-type -bL "$f") in
                  text/*|application/json) $EDITOR "$f";;
                  application/x-executable) "$f";;
                  *) xdg-open "$f" ;;
                esac
              }}'';
      mkdir = ''
        ''${{
                printf "Directory Name: "
                read ans
                mkdir $ans
              }}'';
      mkfile = ''
        ''${{
                printf "File Name: "
                read ans
                $EDITOR $ans
              }}'';
      trash = "%${pkgs.trashy}/bin/trash \"$f\"";
      untrash = "%${pkgs.trashy}/bin/trash restore --force -r 0";
    };

    keybindings = {
      h = "set hidden!"; # toggle hidden files
      c = "copy";
      x = "cut";
      v = "paste";
      "<esc>" = "quit";
      "<enter>" = "open";
      V = "%code $f";
      az = "zip";
      au = "unzip";
      m = "";
      mf = "mkfile";
      md = "mkdir";
      "<delete>" = "trash";
      "<c-delete>" = "untrash";
      "<space>" = "toggle";
      "<c-a>" = "glob-select *";
      "<c-d>" = "unselect";
    };

    extraConfig = let
      previewer = pkgs.writeShellScriptBin "lf_previewer.sh" ''
        case "$(${pkgs.file}/bin/file --mime-type -b "$1")" in
          *text/*)
            ${pkgs.bat}/bin/bat --force-colorization --paging=never --style=changes,numbers --terminal-width $(($2 - 3)) "$1" && false;;
          *)
            ${pkgs.pistol}/bin/pistol "$1";;
        esac
      '';
    in ''
      set previewer ${previewer}/bin/lf_previewer.sh
    '';
  };

  # create icons
  xdg.configFile."lf/icons".text = let
    # define bulk file extensions
    archiveFileExtensions = [
      "tar"
      "tgz"
      "arc"
      "arj"
      "taz"
      "lha"
      "lz4"
      "lzh"
      "lzma"
      "tlz"
      "txz"
      "tzo"
      "t7z"
      "zip"
      "z"
      "dz"
      "gz"
      "lrz"
      "lz"
      "lzo"
      "xz"
      "zst"
      "tzst"
      "bz2"
      "bz"
      "tbz"
      "tbz2"
      "tz"
      "deb"
      "rpm"
      "jar"
      "war"
      "ear"
      "sar"
      "rar"
      "alz"
      "ace"
      "zoo"
      "cpio"
      "7z"
      "rz"
      "cab"
      "wim"
      "swm"
      "dwm"
      "esd"
    ];
    imageFileExtensions = [
      "jpg"
      "jpeg"
      "mjpg"
      "mjpeg"
      "gif"
      "ico"
      "bmp"
      "pbm"
      "pgm"
      "ppm"
      "tga"
      "xbm"
      "xpm"
      "tif"
      "tiff"
      "png"
      "svg"
      "svgz"
      "mng"
      "pcx"
      "mov"
      "mpg"
      "mpeg"
      "m2v"
      "mkv"
      "webm"
      "webp"
      "ogm"
      "mp4"
      "m4v"
      "mp4v"
      "vob"
      "qt"
      "nuv"
      "wmv"
      "asf"
      "rm"
      "rmvb"
      "flc"
      "avi"
      "fli"
      "flv"
      "gl"
      "dl"
      "xcf"
      "xwd"
      "yuv"
      "cgm"
      "emf"
      "ogv"
      "ogx"
    ];
    audioFileExtensions = [
      "aac"
      "au"
      "flac"
      "m4a"
      "mid"
      "midi"
      "mka"
      "mp3"
      "mpc"
      "ogg"
      "ra"
      "wav"
      "oga"
      "opus"
      "spx"
      "xspf"
    ];
  in ''
    # default file types
    ln                # LINK
    or                # ORPHAN
    tw                # STICKY_OTHER_WRITABLE
    ow                # OTHER_WRITABLE
    st                # STICKY
    di                # DIR
    pi              p  # FIFO
    so              s  # SOCK
    bd              b  # BLK
    cd              c  # CHR
    su              u  # SETUID
    sg              g  # SETGID
    ex                # EXEC
    fi                # FILE

    # archives or compressed
    ${lib.concatMapStrings (str: "*." + str + " \n") archiveFileExtensions}

    # image formats
    ${lib.concatMapStrings (str: "*." + str + " \n") imageFileExtensions}

    # audio formats
    ${lib.concatMapStrings (str: "*." + str + " \n") audioFileExtensions}

    # fonts
    *.ttf           
    *.otf           

    # misc
    *.pdf           
  '';
}
