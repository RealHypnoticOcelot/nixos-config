{ pkgs, userName, lib, config, ... }:

{
  programs.vesktop = {
    enable = true;
    settings = {
      discordBranch = "canary";
    };
    vencord.themes = [
      "./themes/pesterchum.css"
    ];
    vencord.settings = {
      plugins = {
        # Alphabetical!
        # I'm pretty sure these plugin names are defined in https://github.com/Vendicated/Vencord/tree/main/src/plugins
        # Inside of index.tsx, there's a "name" property
        # Alternatively, just open up Vencord/Vesktop and see what they're named in the plugins tab
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
      enabledThemes = [ "pesterchum.css" ];
    };
  };
}