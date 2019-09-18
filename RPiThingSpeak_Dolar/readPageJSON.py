#!/usr/bin/env python
#

import json 
import sys
import os

if not len(sys.argv) == 3:
    print("Uso %s <json_file> <campo1> <campo2>"%sys.argv[0])
    print("Si campo1 = 'main' entonces campo2 = [ 'humidity' | 'temp' ]")
    print("Si campo2 = 'wind' entonces campo2 = [ 'speed' ]")
    sys.exit(-1)

homedir = os.environ['HOME']
os.chdir("%s/RPiThingSpeak"%homedir)
filename = sys.argv[1]
campo1 = sys.argv[2]
#campo2 = sys.argv[3]
with open(filename) as json_file:
    data = json.load(json_file)
    #print(data[campo1][campo2])
    print(data[campo1])
