# SingularityHPC
This repository will hold: the build script to install singularity and other dependencies for it, and a definition file for the singularity container for HPC.

To install, run `git clone https://github.com/perminaa/SingularityHPC.git && cd SingularityHPC && bash buildscript.sh`. This will install and configure singularity
and build a container called `container.sif`

To run the container, you can use `singularity shell Container.sif` to run in the singularity shell or `singularity exec Container.sif <command>`.
