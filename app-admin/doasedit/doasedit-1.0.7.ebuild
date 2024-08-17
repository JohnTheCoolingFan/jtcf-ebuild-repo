# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Enable doers to edit non-user-editable files with an unprivileged editor"
HOMEPAGE="https://codeberg.org/TotallyLeGIT/doasedit"
SRC_URI="https://codeberg.org/TotallyLeGIT/doasedit/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~hppa ~ia64 ~loong ~ppc ppc64 ~riscv ~s390 ~sparc ~x86"

DEPEND="app-admin/doas"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	unpack ${P}.tar.gz
	mv doasedit doasedit-${PV}
}

src_install() {
	dobin doasedit
	einstalldocs
}
