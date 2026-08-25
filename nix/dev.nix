{ config, ... }:
{
  programs.git = {
    enable = true;
    settings.user = {
      name = "alexius";
      email = "git@alexius.xyz";
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "alexius";
        email = "git@alexius.xyz";
      };

      ui.diff-formatter = ":git";
      diff.git.context = 8;
    };
  };

  # psql
  home.file.".psqlrc".text = ''
    \setenv PAGER 'less -SFRX'
    \pset pager on
  '';

  # lock npm's global prefix to a user dir
  xdg.configFile."npm/npmrc".text =
    "prefix=${config.home.homeDirectory}/.npm-global\n";
}
