{
  description = ''Shamir secret sharing'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-sss-v0_1_1.flake = false;
  inputs.src-sss-v0_1_1.owner = "markspanbroek";
  inputs.src-sss-v0_1_1.ref   = "refs/tags/v0.1.1";
  inputs.src-sss-v0_1_1.repo  = "sss.nim";
  inputs.src-sss-v0_1_1.type  = "github";
  
  inputs."nimterop".dir   = "nimpkgs/n/nimterop";
  inputs."nimterop".owner = "riinr";
  inputs."nimterop".ref   = "flake-pinning";
  inputs."nimterop".repo  = "flake-nimble";
  inputs."nimterop".type  = "github";
  inputs."nimterop".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimterop".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-sss-v0_1_1"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-sss-v0_1_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}