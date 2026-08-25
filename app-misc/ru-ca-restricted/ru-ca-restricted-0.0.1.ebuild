# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# https://habr.com/ru/articles/1071256/

EAPI=8

DESCRIPTION="Russian government root CA, restricted to russian TLDs"
HOMEPAGE=""
SRC_URI="
	https://gu-st.ru/content/lending/linux_russian_trusted_root_ca_pem.zip
	https://gu-st.ru/content/lending/russian_trusted_sub_ca_pem.zip
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~alpha ~arm ~arm64 ~hppa ~mips ~ppc ~ppc64 ~riscv ~sparc"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/openssl
"

S=${WORKDIR}

inherit ssl-cert

src_compile() {
	openssl req -x509 -days 3650 -newkey rsa:4096 \
		-nodes -keyout ca.key -out ca.crt \
		-subj "/CN=Secured-Private-Root" \
		-addext "basicConstraints = critical,CA:true,pathlen:5" \
		-addext "keyUsage = critical,digitalSignature,keyCertSign,cRLSign" \
		-addext "nameConstraints = critical, permitted;DNS:.ru, permitted;DNS:.su, permitted;DNS:.xn--p1ai"

	openssl req \
		-new -newkey rsa:4096 -nodes \
		-keyout temp.key \
		-out dummy.csr \
		-subj "/CN=Temporary Dummy CSR"

	newsubj="/$(openssl x509 -in russian_trusted_root_ca_pem.crt -noout -subject | sed 's/subject=//g' | sed 's/, /\//g')"

	openssl x509 -in russian_trusted_root_ca_pem.crt -pubkey -noout > digital-gov.pub

	openssl x509 \
		-req -in dummy.csr \
		-CA ca.crt -CAkey ca.key \
		-CAcreateserial -days 3650 -sha256 \
		-force_pubkey digital-gov.pub \
		-out russian_govt_restricted_ca.crt \
		-extfile ${FILESDIR}/cross.conf \
		-extensions cross_ca_ext \
		-subj "${newsubj}"
}

src_install() {
	dodir /etc/ssl/certs/
	cp russian_trusted_sub_ca_pem.crt "${D}/etc/ssl/certs/russian_trusted_sub_ca_pem.crt"
	cp russian_trusted_sub_ca_2024_pem.crt "${D}/etc/ssl/certs/russian_trusted_sub_ca_2024_pem.crt"
	cp russian_govt_restricted_ca.crt "${D}/etc/ssl/certs/russian_govt_restricted_root_ca.crt"
	cp ca.crt "${D}/etc/ssl/certs/russian_govt_restricted_ca.crt"
}

pkg_postinst() {
	"${EROOT}"/usr/sbin/update-ca-certificates
}
