# -*- coding: utf-8 -*-

__author__ = 'Franklin Diaz'
__copyright__ = 'Copyright 2019, '
__credits__ = ['{credit_list}']
__license__ = '{license}'
__version__ = '1.0.0'
__maintainer__ = 'Security Data Engineering'
__email__ = 'frank378@gmail.com'

import yaml
import os, fnmatch

def find(pattern, path):
  result = []
  for root, dirs, files in os.walk(path):
    for name in files:
      if fnmatch.fnmatch(name, pattern):
        result.append(os.path.join(root, name))
  return result


def check_yaml_file(my_file):
  with open(my_file, 'r') as stream:
    try:
      # Uncomment next line to print out all the values
      #print(yaml.load(stream))
      yaml.load(stream)
      print("PASS: YAML test file looks good")
    except yaml.YAMLError as exc:
      pm = exc.problem_mark
      print("ERROR: Your file {} has an issue on line {} at position {}".format(pm.name, pm.line, pm.column))


def main():
  target_dir = os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', 'playbooks'))
  my_yaml = find('*.yml',target_dir)
  i = 0
  while i < len(my_yaml):
    print ("Now checking: ",my_yaml[i])
    check_yaml_file(my_yaml[i])
    i += 1


if __name__ == "__main__":
  main()
