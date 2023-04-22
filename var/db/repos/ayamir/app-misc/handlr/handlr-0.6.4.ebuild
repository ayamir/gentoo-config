# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.15
	arrayvec-0.5.2
	ascii_table-3.0.2
	atty-0.2.14
	autocfg-1.0.1
	base64-0.13.0
	bitflags-1.2.1
	block-buffer-0.7.3
	block-padding-0.1.5
	bumpalo-3.6.1
	byte-tools-0.3.1
	byteorder-1.4.3
	bytes-1.0.1
	cc-1.0.67
	cfg-if-0.1.10
	cfg-if-1.0.0
	clap-3.0.0-beta.2
	clap_derive-3.0.0-beta.2
	confy-0.4.0
	core-foundation-0.9.1
	core-foundation-sys-0.8.2
	digest-0.8.1
	directories-2.0.2
	dirs-next-2.0.0
	dirs-sys-0.3.6
	dirs-sys-next-0.1.2
	either-1.6.1
	encoding_rs-0.8.28
	fake-simd-0.1.2
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	freedesktop_entry_parser-1.1.1
	futures-channel-0.3.14
	futures-core-0.3.14
	futures-sink-0.3.14
	futures-task-0.3.14
	futures-util-0.3.14
	generic-array-0.12.4
	getrandom-0.2.2
	glob-0.3.0
	h2-0.3.3
	hashbrown-0.9.1
	heck-0.3.2
	hermit-abi-0.1.18
	http-0.2.4
	http-body-0.4.1
	httparse-1.4.0
	httpdate-1.0.0
	hyper-0.14.7
	hyper-tls-0.5.0
	idna-0.2.3
	indexmap-1.6.2
	ipnet-2.3.0
	itertools-0.10.0
	itoa-0.4.7
	js-sys-0.3.50
	json-0.12.4
	lazy_static-1.4.0
	lexical-core-0.7.6
	libc-0.2.94
	log-0.4.14
	maplit-1.0.2
	matches-0.1.8
	memchr-2.3.4
	mime-0.3.16
	mime-db-1.3.0
	mio-0.7.11
	miow-0.3.7
	native-tls-0.2.7
	nom-5.1.2
	ntapi-0.3.6
	once_cell-1.7.2
	opaque-debug-0.2.3
	openssl-0.10.34
	openssl-probe-0.1.2
	openssl-sys-0.9.62
	os_str_bytes-2.4.0
	percent-encoding-2.1.0
	pest-2.1.3
	pest_derive-2.1.0
	pest_generator-2.1.3
	pest_meta-2.1.3
	pin-project-1.0.7
	pin-project-internal-1.0.7
	pin-project-lite-0.2.6
	pin-utils-0.1.0
	pkg-config-0.3.19
	ppv-lite86-0.2.10
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.26
	quote-1.0.9
	rand-0.8.3
	rand_chacha-0.3.0
	rand_core-0.6.2
	rand_hc-0.3.0
	redox_syscall-0.2.7
	redox_users-0.4.0
	remove_dir_all-0.5.3
	reqwest-0.11.3
	ryu-1.0.5
	schannel-0.1.19
	security-framework-2.2.0
	security-framework-sys-2.2.0
	serde-1.0.125
	serde_derive-1.0.125
	serde_json-1.0.64
	serde_urlencoded-0.7.0
	sha-1-0.8.2
	shlex-1.0.0
	slab-0.4.3
	socket2-0.4.0
	static_assertions-1.1.0
	strsim-0.10.0
	syn-1.0.71
	tempfile-3.2.0
	termcolor-1.1.2
	textwrap-0.12.1
	thiserror-1.0.24
	thiserror-impl-1.0.24
	tinyvec-1.2.0
	tinyvec_macros-0.1.0
	tokio-1.5.0
	tokio-macros-1.1.0
	tokio-native-tls-0.3.0
	tokio-util-0.6.6
	toml-0.5.8
	tower-service-0.3.1
	tracing-0.1.25
	tracing-core-0.1.17
	try-lock-0.2.3
	typenum-1.13.0
	ucd-trie-0.1.3
	unicase-2.6.0
	unicode-bidi-0.3.5
	unicode-normalization-0.1.17
	unicode-segmentation-1.7.1
	unicode-width-0.1.8
	unicode-xid-0.2.2
	url-2.2.1
	vcpkg-0.2.12
	vec_map-0.8.2
	version_check-0.9.3
	want-0.3.0
	wasi-0.10.2+wasi-snapshot-preview1
	wasm-bindgen-0.2.73
	wasm-bindgen-backend-0.2.73
	wasm-bindgen-futures-0.4.23
	wasm-bindgen-macro-0.2.73
	wasm-bindgen-macro-support-0.2.73
	wasm-bindgen-shared-0.2.73
	web-sys-0.3.50
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	winreg-0.7.0
	xdg-2.2.0
	xdg-mime-0.3.3
"

inherit cargo

DESCRIPTION="Manage mimeapps.list and default applications with ease"
HOMEPAGE="https://github.com/chmln/handlr"
SRC_URI="
		https://github.com/chmln/handlr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		$(cargo_crate_uris ${CRATES})
"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT MPL-2.0 Unlicense X11 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_configure() {
	cargo_src_configure
}

src_install() {
	cargo_src_install

	insinto /usr/share/fish/vendor_completions.d
	doins ${WORKDIR}/${P}/completions/handlr.fish

	insinto /usr/share/zsh/site-functions
	doins ${WORKDIR}/${P}/completions/_handlr

	dodoc README.md
}
