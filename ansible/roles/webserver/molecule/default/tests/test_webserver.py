import os
import pytest


import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


@pytest.mark.parametrize('pkg', [
  'httpd',
  'firewalld'
])
def test_pkg(host, pkg):
    package = host.package(pkg)
    assert package.is_installed


"""
@pytest.mark.parametrize('svc', [
  'httpd',
  'firewalld'
"""


@pytest.mark.parametrize('svc', [
    'httpd'
])
def test_svc(host, svc):
    service = host.service(svc)

    assert service.is_running
    assert service.is_enabled


"""
@pytest.mark.parametrize('file, content', [
  ("/etc/firewalld/zones/public.xml", "<service name=\"http\"/>"),
  ("/var/www/html/index.html", "Managed by Ansible")
])
def test_files(host, file, content):
    file = host.file(file)
    assert file.exists
    assert file.contains(content)
"""


__author__ = 'fdiaz@paloaltonetworks.com'
__copyright__ = 'Copyright 2020'
__credits__ = ['{credit_list}']
__license__ = '{license}'
__version__ = '1.0.0'
__maintainer__ = ''
__email__ = ''