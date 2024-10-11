#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import csv
from os import path
import sys
import yaml

if __name__ == "__main__":
    # TWO arguments mandatory
    args = sys.argv
    if len(args) < 3:
        print('La commande nécessite 2 arguments : input.csv output.yml')
        sys.exit(1)

    input_file = args[1]
    output_file = args[2]
    # The first file should exists
    if not path.isfile(input_file):
        print("{} n'existe pas !".format(input_file))
        sys.exit(1)
    # The second one shouldn't exists
    if path.isfile(output_file):
        print("{} existe déjà !".format(output_file))
        sys.exit(1)

    # Read input file, write in output one
    content = []
    with open(input_file, 'r') as file:
        reader = csv.DictReader(file)
        for idx, line in enumerate(reader):
            if idx == 0:
                continue
            content.append(line)

    if not content:
        print("Aucune ligne dans le fichier {}".format(input_file))
        sys.exit(1)

    with open(output_file, 'w') as yfile:
        yaml.dump(content, yfile, default_flow_style=False)

#    with open(csv_filename, "r") as csv_file:
#        csv_reader = csv.DictReader(csv_file)
#        data = [row for row in csv_reader]
#
#    with open(yaml_filename, "w") as yaml_file:
#        yaml.dump(data, yaml_file, default_flow_style=False)

    sys.exit(0)
