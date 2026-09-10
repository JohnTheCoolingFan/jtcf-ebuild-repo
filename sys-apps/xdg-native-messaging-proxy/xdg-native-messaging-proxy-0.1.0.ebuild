# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Small service which can be used to find native messaging host manifests"
HOMEPAGE="https://github.com/flatpak/xdg-native-messaging-proxy"
SRC_URI="https://github.com/flatpak/xdg-native-messaging-proxy/releases/download/${PV}/xdg-native-messaging-proxy-${PV}.tar.xz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~x86"

DEPEND="
	>=dev-libs/glib-2.72:2
	dev-libs/json-glib
"
RDEPEND="${DEPEND}"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	meson_src_configure
}
