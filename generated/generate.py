import glob
import json
import urllib

for input_file in glob.glob('../dashboards/*.json'):
    with open(input_file) as input_:
        dashboard = json.load(input_)
        title = dashboard["title"]

        wrapper_obj = {
            'user': 'guest',
            'group': 'guest',
            'title': title,
            'dashboard': json.dumps(dashboard)
        }

        output_file = "{}.json".format(urllib.quote_plus(title))
        with open(output_file, "w") as output_:
            json.dump(wrapper_obj, output_)
