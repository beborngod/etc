{
  zen-browser,
  pkgs,
  ...
}:
let
  addons = pkgs.firefox-addons;
in
{
  imports = [ zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    package = null;
    globalExtensions = [
      addons.onepassword-password-manager
      addons.refined-github
      (addons.buildFirefoxXpiAddon {
        pname = "icloud-passwords";
        version = "3.3.0";
        addonId = "password-manager-firefox-extension@apple.com";
        url = "https://addons.mozilla.org/firefox/downloads/file/4747750/icloud_passwords-3.3.0.xpi";
        sha256 = "9f89fbfb0b052453437c6eec8940c62314a9fc24fd31bffcbcfcfb66c106e933";
        meta.license = pkgs.lib.licenses.unfree;
      })
    ];
  };
}
