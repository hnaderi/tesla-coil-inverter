let
  pkgs = import <nixpkgs> { };
  kicad = pkgs.kicad-small;
  compile = pkgs.writeShellScriptBin "compile" ''
    ${kicad}/bin/kicad-cli sch export $1 $2
  '';
  renderPCB = pkgs.writeShellScriptBin "renderPCB" ''
    ${kicad}/bin/kicad-cli pcb render $1 -o $2
  '';
in pkgs.mkShell {
  name = "sstc";
  buildInputs = [ compile renderPCB kicad ];
}
