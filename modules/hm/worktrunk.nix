{pkgs, ...}: let
  tomlFormat = pkgs.formats.toml {};
in {
  xdg.configFile."worktrunk/config.toml".source = tomlFormat.generate "worktrunk-config.toml" {
    "worktree-path" = "{{ repo_path }}/../{{ repo }}.{{ branch | sanitize }}";

    commit.generation.command = "opencode run -m openai/gpt-5.4-mini-fast --variant low";

    list = {
      summary = true;
      full = true;
    };

    aliases = {
      oc = ''wt switch --create {{ to }} --execute="opencode {{ args }}"'';
      ocrun = ''wt switch --create {{ to }} --execute="opencode run {{ args }}"'';
    };
  };
}
