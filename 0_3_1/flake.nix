{
  description = ''Shamir secret sharing'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-sss-0_3_1.flake = false;
  inputs.src-sss-0_3_1.owner = "markspanbroek";
  inputs.src-sss-0_3_1.ref   = "refs/tags/0.3.1";
  inputs.src-sss-0_3_1.repo  = "sss.nim";
  inputs.src-sss-0_3_1.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-sss-0_3_1"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-sss-0_3_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}