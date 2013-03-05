VRF-VYATTA
==========

vrf-vyatta is vrf module for vyatta. It enables that you can configure
_vrf_ in top level of configure mode. It uses Linux Name Space. vrf-vyatta
enables that protocl static, ospf, and ospfv3 processes can be run on
a vrf instance. And only vlan interface can be attached into vrf.


vrf-vyatta requires alternative quagga and iproute2. 

Install Quagga
--------------

vrf-vyatta requires quagga software that is applied multi vtysh patch.
The patch url is here <http://lists.quagga.net/pipermail/quagga-dev/2012-July/009627.html>.
This patch can be applied to only quagga release 0.99.22.

	 % wget http://download.savannah.gnu.org/releases/quagga/quagga-0.99.21.tar.gz
	 % tar zxvf quagga-0.99.21.tar.gz
	 % cd quagga-0.99.21
	 % patch -p1 < quagga-multi-vty.patch
	 % ./configure --enable-vtysh
	 % make
	 % make install

This quagga routing softwares (ospfd, ospf6d, zebra) are installed to /usr/local/sbin,
and vtysh is installed to /usr/local/bin directory. Don't change these prefixes because
they are hardcoded into vyatta cli extensions for vrf. Preinstalled quagga softwares are
installed to /usr/*bin directories.


Install iproute2
----------------

Preinstalled iproute2 (iproute2-ss120801) on VC6.5 can not exec commands on network namespace.
So please install new iproute2 (I have tested with iproute2-ss121211).

	 % wget https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-3.7.0.tar.gz
	 % tar zxvf iproute2-3.7.0.tar.gz
	 % cd iproute2-3.7.0
	 % ./configure
	 % make
	 % make install

This ip command is installed to /sbin directory (original ip command is in /sbin).
This prefix is also used on cli extensions.

