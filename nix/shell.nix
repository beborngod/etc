{ ... }:
{
  home.sessionVariables = {
    EDITOR = "hx";
    GIT_EDITOR = "hx";
    PAGER = "less -SR";
  };

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
    "/nix/var/nix/profiles/default/bin"
    "$HOME/.local/bin"
    "$HOME/.npm-global/bin"
  ];

  home.shellAliases = {
    ext = "exit";

    #console
    l = "eza -la --git";
    la = "eza --tree --level=2 --long --git";
    lt = "l --tree";
    ls = "eza";
    fs = "fzf";
    cl = "clear";
    tm = "tmux";
    h = "helix";
    
    # jujutsu II
    jp = "jj git push";
    js = "jj st --no-pager";
    jl = "jj log";
    jd = "jj desc";
    jn = "jj new";
    je = "jj edit";
    jr = "jj rebase -d";
    jf = "jj git fetch";
    jt = "jj b track";

    # jujutsu III
    jnm = "jn master";
    jsq = "jj squash";
    jdf = "jj diff";
    jff = "jj diff";
    jbs = "jj b set";
    jbc = "jj b create";
    jrm = "jj rebase -d master";
    jsp = "jj split";
    jol = "jj op log";
    jfs = "jj diff --stat";
    jor = "jj op restore";
    
    # jujutsu porn
    jfrm = "jf; jrm";
    jffs = "jj diff --stat";
    jsqi = "jj squash --into";
    jbsm = "jbs master -r @";

    # brain tools
    sjp = "cargo +nightly fmt; jj git push";

    # nix / system aliases
    upd = "home-manager switch --flake ~/.config/nix#alx";
    update = "home-manager switch --flake ~/.config/nix#alx";
    nix-gc = "nix-collect-garbage -d";
        
    #nix dev
    start = "nix run .#services -- up external";
    dev = "nix develop";

    #cargo
    fmt = "cargo +nightly fmt";
    check = "cargo check";

    clippy = "cargo clippy --all-features --all-targets --no-deps -- -Dwarnings";
    run = "cargo run --bin";
    build = "nix run ..#build-static-release -- --bin";

    #short cargo
    cc = "cl; clippy";
    cb = "cl; cargo build";
    ct = "cl; cargo test";
    t = "cargo test";

    # sqlx
    prepare = "cargo sqlx prepare --database-url";
  };

  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--preview-window border-rounded"
      "--layout reverse"
      "--exact" # turn off fuzzy matching
      "--color 16"
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    initContent = ''
      setopt PROMPT_SUBST

      cx() { cd "$@" && eza -la --git; }

      jj_bookmark() {
        if jj root &>/dev/null; then
          local bookmark=$(jj log -r @ --no-graph --color=never -T 'bookmarks' 2>/dev/null | tr -d ' ')
          [[ -n "$bookmark" ]] && echo " %F{blue}jj:%f%F{cyan}($bookmark)%f"
        else
          local branch=$(git branch --show-current 2>/dev/null)
          [[ -n "$branch" ]] && echo " %F{green}git:%f%F{yellow}($branch)%f"
        fi
      }

      export PS1="%B[%2~]%b:\$(jj_bookmark) $ "
    '';
  };

  programs.bash = {
    enable = true;

    bashrcExtra = ''
      PROMPT_DIRTRIM=2

      cx() { cd "$@" && eza -la --git; }

      jj_bookmark() {
        if jj root &>/dev/null 2>&1; then
          local bookmark=$(jj log -r @ --no-graph --color=never -T 'bookmarks' 2>/dev/null | tr -d ' ')
          [[ -n "$bookmark" ]] && printf " \033[34mjj:\033[0m\033[36m(%s)\033[0m" "$bookmark"
        else
          local branch=$(git branch --show-current 2>/dev/null)
          [[ -n "$branch" ]] && printf " \033[32mgit:\033[0m\033[33m(%s)\033[0m" "$branch"
        fi
      }

      PS1="\[\033[1m\][\$(basename \"\$(dirname \"\$PWD\")\")/\$(basename \"\$PWD\")]\[\033[0m\]:\$(jj_bookmark) $ "
    '';
  };

  programs.fish = {
    enable = true;

    functions = {
      jj_bookmark = ''
        if jj root >/dev/null 2>&1
          set bookmark (jj log -r @ --no-graph --color=never -T 'bookmarks' 2>/dev/null | tr -d ' ')
          if test -n "$bookmark"
            echo -n " "(set_color blue)"jj:"(set_color normal)(set_color cyan)"($bookmark)"(set_color normal)
            return
          end
        end
        set branch (git branch --show-current 2>/dev/null)
        if test -n "$branch"
          echo -n " "(set_color green)"git:"(set_color normal)(set_color yellow)"($branch)"(set_color normal)
        end
      '';

      short_pwd = ''
        set -l current_path (pwd)
        set -l home_path $HOME
        
        # Replace home directory with ~
        if string match -q "$home_path*" $current_path
          set current_path (string replace $home_path "~" $current_path)
        end
        
        # Handle the special case where we're exactly at ~
        if test "$current_path" = "~"
          echo "~"
          return
        end
        
        set -l path_parts (string split '/' $current_path)
        set -l num_parts (count $path_parts)
        
        # Show last 2 components (emulating zsh %2~)
        if test $num_parts -gt 2
          echo $path_parts[-2]"/"$path_parts[-1]
        else
          echo $current_path
        end
      '';

      fish_prompt = ''
        set_color --bold
        echo -n "["(short_pwd)"]"
        set_color normal
        echo -n ":"
        jj_bookmark
        echo -n " \$ "
      '';
    };
  };
}
