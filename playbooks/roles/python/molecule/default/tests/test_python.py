# -*- coding: utf-8 -*-

import os
import pytest
import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


@pytest.mark.parametrize('file, content', [
    ("/home/secdevops/setup_python.sh", "cd")
])
def test_files(host, file, content):
    file = host.file(file)

    assert file.exists
    assert file.contains(content)


__author__ = 'frank378@gmail.com'
__copyright__ = 'Copyright 2019'
__credits__ = ['{credit_list}']
__license__ = '{license}'
__version__ = '1.0.0'
__maintainer__ = 'Security Data Engineering'
__email__ = ''
