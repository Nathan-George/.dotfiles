# lf config
{pkgs, ...}: let
  wrapper_script = "${pkgs.writeShellScriptBin "lf_wrapper" ''
    cleanup() {
      # Clean up the tempdir if and only if we created it.
      if [ "$cleanup_tempdir" = "1" ]; then
        rm -r "$LF_TEMPDIR" 2>/dev/null
      fi
      kill $ueberzugpid 2>/dev/null
    }

    # Set up a temporary directory if not alreay done so by a calling
    # wrapper script (e.g. lfcd).
    if [ -z "$LF_TEMPDIR" ]; then
      cleanup_tempdir=1
      export LF_TEMPDIR="$(${pkgs.mktemp}/bin/mktemp -d -t lf-tempdir-XXXXXX)"
    fi

    trap cleanup INT

    export LF_FIFO_UEBERZUG="$LF_TEMPDIR/fifo"
    mkfifo "$LF_FIFO_UEBERZUG"
    tail -f "$LF_FIFO_UEBERZUG" | ${pkgs.ueberzugpp}/bin/ueberzug layer --silent &
    ueberzugpid=$!

    # open lf, then cd to the last directory upon close
    cd "$(command lf -print-last-dir "$@")"

    cleanup
  ''}/bin/lf_wrapper";

  cleaner_script = "${pkgs.writeShellScriptBin "lf_cleaner" ''
    cat <<EOF | paste -s -d ''' > "$LF_FIFO_UEBERZUG"
    {
    "action": "remove",
    "identifier": "lf-preview"
    }
    EOF
  ''}/bin/lf_cleaner";

  previewer_script = "${pkgs.writeShellScriptBin "lf_previewer" ''
    preview() {
      cat <<STOP | paste -s -d ''' > "$LF_FIFO_UEBERZUG"
    {
    "action": "add", "identifier": "lf-preview",
    "path": "$1", "x": $4, "y": $5, "width": $2, "height": $3,
    "scaler": "contain"
    }
    STOP
    }

    ${cleaner_script} # clean active preview

    file="$1"; shift
    case "$(${pkgs.file}/bin/file --mime-type -b "$file")" in
    text/*)
      ${pkgs.bat}/bin/bat --force-colorization --paging=never --style=changes,numbers --terminal-width $(($1 - 3)) "$file" && false;;
    video/*)
      thumbnail="$LF_TEMPDIR/thumbnail.png"
      ${pkgs.ffmpeg}/bin/ffmpeg -y -i "$file" -vframes 1 "$thumbnail"
      preview "$thumbnail" "$@"
      ;;
    application/pdf)
      thumbnail="$LF_TEMPDIR/thumbnail.png"
      ${pkgs.ghostscript_headless}/bin/gs -o "$thumbnail" -sDEVICE=pngalpha -dLastPage=1 "$file" >/dev/null
      preview "$thumbnail" "$@"
      ;;
    image/svg+xml)
      thumbnail="$LF_TEMPDIR/thumbnail.png"
      ${pkgs.imagemagick}/bin/convert "$file" "$thumbnail"
      preview "$thumbnail" "$@"
      ;;
    image/*)
      preview "$file" "$@"
      ;;
    *)
      ${pkgs.pistol}/bin/pistol "$1"
      ;;
    esac
    return 127 # nonzero retcode required for lf previews to reload
  ''}/bin/lf_previewer";
in {
  home.packages = with pkgs; [
    font-awesome
    chafa
    ueberzugpp
  ];

  # make lf default file explorer
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "lf.desktop";
    };
  };

  # wrapper script
  home.shellAliases.lf = wrapper_script;
  # home.shellAliases.lf = ". ${wrapper_script}";

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

    previewer.source = previewer_script;

    extraConfig = ''
      set cleaner ${cleaner_script}
    '';
  };

  # icons
  xdg.configFile."lf/icons".source = ./icons;
}
