# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Proposal for XDG terminal execution utility"
HOMEPAGE="https://gitlab.freedesktop.org/Vladimir-csp/xdg-terminal-exec"
SRC_URI="http://gitlab.freedesktop.org/Vladimir-csp/xdg-terminal-exec/-/archive/v${PV}/xdg-terminal-exec-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"

BDEPEND="app-text/scdoc"

src_prepare() {
	default
	sed -i 's/\$(prefix)/\$(DESTDIR)\/\$(prefix)/' Makefile
}

src_compile() {
	emake prefix="${D}" install
}
