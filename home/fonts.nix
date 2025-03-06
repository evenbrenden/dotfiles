{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = [ pkgs.dejavu_fonts ];
  # Fixes some blocky fonts in Firefox
  xdg.configFile."fontconfig/conf.d/70-no-bitmaps.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <!-- Disable bitmap fonts -->
      <selectfont>
        <rejectfont>
          <pattern>
            <patelt name="scalable"><bool>false</bool></patelt>
          </pattern>
        </rejectfont>
      </selectfont>
    </fontconfig>
  '';
}
