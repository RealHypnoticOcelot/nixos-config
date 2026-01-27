{
  programs.thunderbird = {
    enable = true;
    settings = {
      "datareporting.healthreport.uploadEnabled" = false; # Disable sending technical and interaction data to Mozilla
      "mail.chat.enabled" = false; # Chat feature
      "mailnews.start_page.enabled" = false; # Whether the Start Page opens upon launch
      "mail.shell.checkDefaultClient" = false; # Check if Thunderbird is default mail client on launch
    };
    profiles = {
      default = {
        isDefault = true;
        search.engines = {
          Startpage = {
            name = "Startpage";
            description = "Startpage Search";
            urls = [
              {
                template = "https://www.startpage.com/sp/search";
                params = {
                  { name = "query"; value = "{searchTerms}"; }
                  { name = "prfe"; value = "d05529b22695d9b21ff0bfe3d59b0435c473b251863471092ba162b9a294373c050a20e9412164b63e1334d4b1fc2d4580f9085c3c08441b6809c72c78d039363453dbf0f832bdceebc83f234de3"; }
                  # REALLY long, but this contains user preferences! Now, when we search, theme and everything will always be set by default.
                };
                icon = "https://www.startpage.com/favicon.ico";
                method = "POST";
              }
            ];
          };
        };
        search.force = true; # Force replace the existing search configuration
      };
    };
  };
}