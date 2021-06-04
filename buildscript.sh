#!/bin/bash

# Removes any old singularity and go files
rm -rf /usr/local/libexec/singularity
rm -rf /usr/local/etc/singularity
rm -rf /usr/local/include/singularity
rm -rf /usr/local/lib/singularity
rm -rf /usr/local/var/lib/singularity/
rm -f /usr/local/bin/singularity
rm -f /usr/local/bin/run-singularity
rm -f /usr/local/etc/bash_completion.d/singularity
rm -rf /usr/local/go
rm -rf singularity*
rm -rf go
rm *.sif
echo 'Removing/Cleaning Up Previous Versions Complete'
echo 'Installing Required Packages'

# Installs essential packages
sudo apt-get update && sudo apt-get install -y \
	build-essential \
	libssl-dev \
	uuid-dev \
	libgpgme11-dev \
	squashfs-tools \
	libseccomp-dev \
	wget \
	pkg-config \
	git \
	cryptsetup

echo 'Installing Go'

# Installs Go
export VERSION=1.16.4 OS=linux ARCH=amd64 &&
	wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz &&
	sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz &&
	rm go$VERSION.$OS-$ARCH.tar.gz

echo 'export PATH=/usr/local/go/bin:$PATH' >>~/.bashrc &&
	source ~/.bashrc

echo 'Installing SingularityCE'

# Installs Singularity
export VERSION=3.7.3 && # adjust this as necessary \
	wget https://github.com/hpcng/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz &&
	tar -xzf singularity-${VERSION}.tar.gz &&
	cd singularity

echo 'Compiling the SingularityCE source code'

# Compiles SingularityCE
./mconfig &&
	make -C builddir &&
	sudo make -C builddir install
echo 'Installation Finished'

# Switches to home directory
cd ..
# Removes any tar files

rm singularity-*.gz

# Runs the definition file
singularity build vmdContainer.sif Singularity
singularity shell vmdContainer.sif
