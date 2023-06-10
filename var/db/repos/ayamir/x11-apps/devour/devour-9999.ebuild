# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 desktop

DESCRIPTION="X11 window swallower"
HOMEPAGE="https://github.com/salman-abedin/devour"
EGIT_REPO_URI="https://github.com/salman-abedin/devour.git"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="shellalias"
DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"
BDEPEND=""
RESRICT="mirror"
S="${WORKDIR}"

QA_PREBUILT="*"

src_compile() {
	cd "${S}/${P}"
	if use shellalias; then
		patch -s "devour-shellalias-10.0.diff" || die
	fi
	emake
}

src_install() {
	cd "${S}/${P}"
	make BIN_DIR="${D}/usr/bin" install
}
