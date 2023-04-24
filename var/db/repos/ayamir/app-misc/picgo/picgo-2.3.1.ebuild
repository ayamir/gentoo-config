# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg desktop

DESCRIPTION="A simple & beautiful tool for pictures uploading built by vue-cli-electron-builder."
HOMEPAGE="https://molunerfinn.com/PicGo"
SRC_URI="https://github.com/Molunerfinn/PicGo/archive/refs/tags/v${PV}.tar.gz -> picgo-v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="strip network-sandbox"

DEPEND=""
RDEPEND=""
BDEPEND="
	sys-apps/yarn
"

QA_PREBUILT="*"

S="${WORKDIR}/PicGo-${PV}"

src_configure() {
	yarn || die
}

src_compile() {
	yarn electron:build || die
}

src_install() {
	insinto "/opt"
	doins -r "${S}/dist_electron/linux-unpacked"
	mv "${ED}/opt/linux-unpacked" "${ED}/opt/${PN}"
	cp "build/icons/256x256.png" "build/icons/picgo.png"
	doicon -s 256 "build/icons/picgo.png"
	echo "[Desktop Entry]
Name=PicGo
Comment=Easy to upload your pic & copy to write
Exec=/usr/bin/picgo %U
Terminal=false
Type=Application
Icon=picgo
StartupWMClass=PicGo
X-AppImage-Version=2.3.1
Categories=Utility;
MimeType=x-scheme-handler/picgo" >"${T}/picgo.desktop" || die
	domenu "${T}/picgo.desktop"
	dosym -r "/opt/${PN}/picgo" "/usr/bin/picgo"
	fperms 0755 "/opt/${PN}" -R
}

pkg_postinst() {
	xdg_icon_cache_update
}
