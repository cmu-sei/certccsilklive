import pytest


def test_fixbuf_version(host):
    version = "2.4.2"
    command = """PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig \
                 pkg-config --modversion libfixbuf"""

    cmd = host.run(command)

    assert version in cmd.stdout


def test_silk_version(host):
    version = "3.22.2"
    command = """/usr/local/bin/silk_config --silk-version"""

    cmd = host.run(command)

    assert version in cmd.stdout


def test_yaf_version(host):
    version = "2.15.0"
    command = """PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig \
                 pkg-config --modversion libyaf"""

    cmd = host.run(command)

    assert version in cmd.stdout


def test_super_mediator_version(host):
    version = "1.10.0"
    command = r"""LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH \
                 PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig \
                 /usr/local/bin/super_mediator --version 2>&1 | \
                 head -n1 | egrep -o '([0-9]{1,}\.)+[0-9]{1,}'"""
    cmd = host.run(command)

    assert version in cmd.stdout


def test_pyfixbuf(host):
    version = "0.9.0"

    pyfixbuf = host.pip("pyfixbuf")

    assert pyfixbuf.is_installed
    assert version == pyfixbuf.version
