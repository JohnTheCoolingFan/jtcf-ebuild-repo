# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 git-r3

DESCRIPTION="Linux Kernel Driver for Xbox/Xbox 360 Controllers modified to work with XONE"
HOMEPAGE="https://github.com/forkymcforkface/xpad-noone"

EGIT_REPO_URI="https://github.com/forkymcforkface/xpad-noone.git"

LICENSE="GPL-2"
SLOT="0"

CONFIG_CHECK="SND CFG80211 INPUT_FF_MEMLESS USB POWER_SUPPLY LEDS_CLASS HID"
MODULES_KERNEL_MIN=5.13

src_prepare() {
	cp "${FILESDIR}/Makefile" "${S}" || die
	default
}

src_compile() {
	local modlist=(
		xpad-noone=/extra
	)

	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
}
