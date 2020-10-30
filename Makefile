.ONESHELL:
SHELL = /bin/bash
.SHELLFLASG += -e

all:
	# Build the package
	pushd ./libra-cli
	
	dpkg-buildpackage -rfakeroot -b -us -uc -Ppkg.frr.nortrlib

	popd

install: 
	sudo dpkg -i --force-overwrite libra-cli_1.0.1_amd64.deb

clean:
	rm *.deb
	rm *.buildinfo
	rm *.changes
