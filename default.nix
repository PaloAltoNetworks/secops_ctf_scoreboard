{ pkgs ? import <nixpkgs> {} }:

pkgs.dockerTools.buildImage {
  name = "secops_ctf_scoreboard";
  config = {
    Cmd = [ "bash packer/ctfd_setup.sh" ];
    WorkingDir = "/project";
    Volumes = { 
        "/project" = {};
    };
  };
}