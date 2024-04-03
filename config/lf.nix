# lf config

{ config, lib, pkgs, ... }:

{

  # install font awesome
  home.packages = [ pkgs.font-awesome ];

  # config
  programs.lf = {
    enable = true;

    settings = {
      preview = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
      wrapscroll = true;
    };

    commands = {
  
    };

    keybindings = {
      h = "set hidden!";
      c = "copy";
      x = "cut";
      v = "paste";
      "<esc>" = "quit";
      "<delete>" = "delete";
    };

    extraConfig = 
    let 
      previewer = 
        pkgs.writeShellScriptBin "pv.sh" ''
        file=$1
        w=$2
        h=$3
        x=$4
        y=$5
        
        if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
            ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
            exit 1
        fi
        
        ${pkgs.pistol}/bin/pistol "$file"
      '';
      cleaner = pkgs.writeShellScriptBin "clean.sh" ''
        ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
      '';
    in
    ''
      set cleaner ${cleaner}/bin/clean.sh
      set previewer ${previewer}/bin/pv.sh
    '';
  };


  # create icons
  xdg.configFile."lf/icons".text = let

    # define bulk file extensions
    archiveFileExtensions = [
      "tar" "tgz" "arc" "arj" "taz" "lha" "lz4" "lzh" "lzma" "tlz" "txz" "tzo" "t7z" "zip" "z" "dz" "gz" "lrz" "lz" "lzo"
      "xz" "zst" "tzst" "bz2" "bz" "tbz" "tbz2" "tz" "deb" "rpm" "jar" "war" "ear" "sar" "rar" "alz" "ace" "zoo" "cpio"
      "7z" "rz" "cab" "wim" "swm" "dwm" "esd"
    ];
    imageFileExtensions = [
      "jpg" "jpeg" "mjpg" "mjpeg" "gif" "ico" "bmp" "pbm" "pgm" "ppm" "tga" "xbm" "xpm" "tif" "tiff" "png" "svg" "svgz"
      "mng" "pcx" "mov" "mpg" "mpeg" "m2v" "mkv" "webm" "webp" "ogm" "mp4" "m4v" "mp4v" "vob" "qt" "nuv" "wmv" "asf" "rm"
      "rmvb" "flc" "avi" "fli" "flv" "gl" "dl" "xcf" "xwd" "yuv" "cgm" "emf" "ogv" "ogx"
    ];
    audioFileExtensions = [
      "aac" "au" "flac" "m4a" "mid" "midi" "mka" "mp3" "mpc" "ogg" "ra" "wav" "oga" "opus" "spx" "xspf"
    ];
    codeFileExtensions = [
      "styl" "sass" "scss" "htm" "html" "slim" "haml" "ejs" "css" "less" "rmd" "json" "webmanifest" "js" "mjs" "jsx" "rb"
      "gemspec" "rake" "php" "twig" "cpp" "c++" "cxx" "cc" "cp" "c" "cs" "h" "hh" "hpp" "hxx" "hs" "lhs" "lua" "java" "sh"
      "fish" "bash" "zsh" "ksh" "csh" "awk" "ps1" "ml" "mli" "scala" "go"
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
    ${lib.concatMapStrings (str: "*."+str+" \n") archiveFileExtensions}

    # image formats
    ${lib.concatMapStrings (str: "*."+str+" \n") imageFileExtensions}
    
    # audio formats
    ${lib.concatMapStrings (str: "*."+str+" \n") audioFileExtensions}

    # code
    ${lib.concatMapStrings (str: "*."+str+" \n") codeFileExtensions}
    *.py            
    *.pyc           
    *.pyo           
    *.pyd           
    *.nix           

    # databases
    *.db            
    *.sql           

    # configuration
    *.conf          
    *.ini           
    *.yml           
    *.yaml          
    *.toml          
    *.bat           
    *.mk            
    
    # adobe stuff
    *.ai            
    *.psd           

    # latex
    *.tex           

    # markdown
    *.md            
    *.mdx           
    *.markdown      

    # fonts
    *.ttf           
    *.otf           

    # misc
    *.pdf           
    *.dump          
    *.diff          
    *.ds_store      
    *.DS_Store      
    *.gitconfig     
    *.gitignore     
    *.gitattributes 
    *.bashrc        
    *makefile       
    *Makefile       
  '';

}