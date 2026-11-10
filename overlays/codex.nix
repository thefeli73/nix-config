final: prev: {
  # Codex omits libraries required by nixpkgs' system-library Cargo hook.
  codex = prev.codex.overrideAttrs (old: {
    buildInputs =
      old.buildInputs
      ++ [
        final.aws-lc
        final.oniguruma
        final.sqlite
        final.zstd
      ];
  });
}
