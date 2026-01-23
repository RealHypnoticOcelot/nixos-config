{ pkgs, userName, lib, config, ... }:

{
  programs.vesktop = {
    enable = true;
    settings = {
      discordBranch = "canary";
    };
    vencord.themes = {
      "Pesterchum" = ./themes/pesterchum.css;
    };
    vencord.settings = {
      plugins = {
        # Alphabetical!
        # I'm pretty sure these plugin names are defined in https://github.com/Vendicated/Vencord/tree/main/src/plugins
        # Inside of index.tsx, there's a "name" property
        # Alternatively, just open up Vencord/Vesktop and see what they're named in the plugins tab
        # You can ALSO just open Vencord/Vesktop settings and click "Open Settings Folder", and navigate to settings.json
        AlwaysExpandRoles.enabled = true;
        BetterRoleContext.enabled = true;
        BetterSettings.enabled = true;
        ClearURLs.enabled = true;
        CopyEmojiMarkdown.enabled = true;
        CopyFileContents.enabled = true;
        CopyStickerLinks.enabled = true;
        CopyUserURLs.enabled = true;
        CrashHandler.enabled = true;
        DisableCallIdle.enabled = true;
        Experiments = {
          enabled = true;
          toolbarDevMenu = true;
          # This option is also found in aforementioned repository, in aforementioned index files
        };
        ExpressionCloner.enabled = true;
        FavoriteGifSearch.enabled = true;
        ForceOwnerCrown.enabled = true;
        FriendsSince.enabled = true;
        iLoveSpam.enabled = true;
        NormalizeMessageLinks.enabled = true;
        NoUnblockToJump.enabled = true;
        PauseInvitesForever.enabled = true;
        PermissionFreeWill.enabled = true;
        PinDMs = {
          enabled = true;
          pinOrder = 1;
          # 1 = Custom: Allows rearranging the order of your pinned DMs
          # I believe with drop-down options, you select a zero-indexed option number(so the first option would be 0, the next would be 1, etc.)
          userBasedCategoryList = {
            "404053132910395393" = [ # Your user ID
              {
                id = "mainPins";
                name = "Pins";
                color = 8027011; # The color of the category name in decimal format, NOT hexadecimal(You'll have to convert, for example #15e209 is equal to 1434121)
                collapsed = false;
                channels = [ # Channel IDs for channels you want to pin. DIFFERENT from user IDs! 
                  "1172645088925585520" 
                  "766857547155636224"
                ];
              }
            ]
          }
        };
        ReplaceGoogleSearch = {
          enabled = true;
          customEngineName = "Startpage";
          customEngineURL = "https://www.startpage.com/sp/search?query=";
          replacementEngine = 1;
          # 1 = Custom Engine
          # Technically, Startpage already exists as a non-custom option, but this configuration is more resilient to changes in the DefaultEngines array.
        };
        ShowHiddenThings.enabled = true;
        ShowTimeoutDuration = {
          enabled = true;
          displayStyle = 0;
          # 0 = In the Tooltip, when hovered over
        };
        Translate.enabled = true;
        Unindent.enabled = true;
        UnsuppressEmbeds.enabled = true;
        ValidReply.enabled = true;
        ValidUser.enabled = true;
        ViewIcons.enabled = true;
        VoiceDownload.enabled = true;
        VoiceMessages.enabled = true;
        YoutubeAdblock.enabled = true;
      };
      enabledThemes = [ "Pesterchum.css" ]; # You have to append ".css" to whatever theme is named up in vencord.themes
    };
  };
}