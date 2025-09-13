# Copyright 2025 JohnTheCoolingFan
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Saitek X52/X52pro drivers & controller mapping software for Linux"
HOMEPAGE="https://nirenjan.github.io/libx52/"
SRC_URI="
	https://github.com/nirenjan/libx52/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/hidapi
	>=virtual/libusb-1
	dev-libs/libevdev
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	eautoreconf --install
	econf
}
