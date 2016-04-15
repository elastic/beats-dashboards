# Read json file
# read file
# Convert proper json element
# Escape
# Print out

import os
import json
import pprint


def unescape_json(escaped):
    obj = json.loads(escaped)
    return json.dumps(obj, sort_keys=True, indent=4, separators=(',', ': '))

def load_json(filepath):
    json_data=open(filepath).read()
    return json.loads(json_data)

def load():

    filepath = '../dashboards/dashboard/HTTP.json'
    data = load_json(filepath)

    print unescape_json(data["kibanaSavedObjectMeta"]["searchSourceJSON"])


def load_index_pattern_fields(file):
    filepath = '../dashboards/index-pattern/' + file
    data = load_json(filepath)

    return unescape_json(data["fields"])


def load_index_pattern_fieldFormatMap(file):
    filepath = '../dashboards/index-pattern/' + file
    data = load_json(filepath)

    if  data.has_key("fieldFormatMap"):
        return unescape_json(data["fieldFormatMap"])
    else:
        return ""

def extract_index_patterns():

    base_dir = '../dashboards/index-pattern/'
    files = os.listdir('../dashboards/index-pattern/')


    for file in files :
        # Only json files
        if os.path.isfile(base_dir + file) and os.path.splitext(file)[1] == '.json':

            dir_name = os.path.splitext(file)[0]
            dir = base_dir + dir_name

            if not os.path.exists(dir):
                os.mkdir(dir)

            fields = load_index_pattern_fields(file)

            with open(dir + "/fields.json", 'w') as outfile:
                outfile.write(fields)

            fieldFormatMap = load_index_pattern_fieldFormatMap(file)

            with open(dir + "/fieldFormatMap.json", 'w') as outfile:
                outfile.write(fieldFormatMap)

extract_index_patterns()
