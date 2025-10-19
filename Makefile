.POSIX:
.PHONY: default build test diff update install

default: build

config:
	nixos-generate-config \
		--show-hardware-config > ThinkpadP16s/hardware-configuration.nix

build:
	sudo nixos-rebuild \
		--flake '.#ThinkpadP16s' \
		switch

test:
	nixos-rebuild \
		--flake '.#ThinkpadP16s' \
		build-vm
	./result/bin/run-ThinkpadP16s-vm

diff:
	nixos-rebuild \
		--flake '.#ThinkpadP16s' \
		build
	nix store diff-closures \
		--allow-symlinked-store \
		/nix/var/nix/profiles/system ./result

update:
	nix flake update

clean:
	nix-collect-garbage --delete-older-than 7d --log-format bar
