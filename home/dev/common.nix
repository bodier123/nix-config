{ config, pkgs, ... }:
{
  home.username = "dev";
  home.homeDirectory = "/home/dev";

  programs.git = {
    enable = true;
    userName = "dev";
    userEmail = "dev@example.com";
  };

  programs.zsh.enable = true;
  programs.starship.enable = true;

  home.packages = with pkgs; [
    tmux
    neovim
    tree
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.stateVersion = "25.05";
  programs.nushell.enable = true;
  # --- NU_PROMPT_BLOCK: pretty Nushell prompt + UX --------------------------------
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = "$directory$git_branch$git_status$cmd_duration$nix_shell$line_break$character";
      character = { success_symbol = "❯"; error_symbol = "❯"; vicmd_symbol = "❮"; };
      cmd_duration = { min_time = 2000; format = " [$duration] "; };
      directory = { truncation_length = 3; truncation_symbol = "…/"; style = "bold cyan"; };
      git_branch = { format = " [$branch] "; truncation_length = 32; truncation_symbol = "…/"; };
      git_status = { format = " [\\[$all_status$ahead_behind\\]] "; };
      nix_shell = { format = " in [$state]($style)"; heuristic = true; style = "bold purple"; };
    };
  };

  programs.zoxide = { enable = true; enableNushellIntegration = true; };
  programs.eza     = { enable = true; enableNushellIntegration = true; };
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.carapace = { enable = true; enableNushellIntegration = true; };

  programs.nushell.shellAliases = {
    ls = "eza --group-directories-first";
    ll = "eza -lah --group-directories-first";
    la = "eza -la";
    cat = "bat";
    grep = "rg";
    find = "fd";
  };

  programs.nushell.extraConfig = 
    $env.STARSHIP_SHELL = "nu"
    $env.PROMPT_COMMAND = {|| starship prompt }
    $env.PROMPT_COMMAND_RIGHT = {|| "" }
    $env.PROMPT_INDICATOR = {|| "❯ " }
    $env.PROMPT_INDICATOR_VI_INSERT = {|| "❯ " }
    $env.PROMPT_MULTILINE_INDICATOR = {|| "⋮ " }

    $env.config = {
      show_banner: false
      edit_mode: "vi"
      render_right_prompt_on_last_line: true
      completion: { algorithm: "fuzzy", case_sensitive: false, use_ls_colors: true }
      cursor_shape: { vi_insert: "line", vi_normal: "block" }
    }
  ;
  # ------------------------------------------------------------------------------- 
}
