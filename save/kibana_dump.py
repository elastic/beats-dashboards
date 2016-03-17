from elasticsearch import Elasticsearch
import argparse
import os
import json


def dump_objects(es, output_directory, index, doc_type):
    res = es.search(
        index=index,
        doc_type=doc_type,
        size=1000)

    dir = os.path.join(output_directory, doc_type)
    if not os.path.exists(dir):
        os.makedirs(dir)

    for doc in res['hits']['hits']:
        filepath = os.path.join(dir, doc['_id'] + '.json')
        with open(filepath, 'w') as f:
            json.dump(doc['_source'], f, indent=2)
            print("Written {}".format(filepath))


def main():
    parser = argparse.ArgumentParser(
        description="Dumps Kibana dashboards, vizualization and " +
                    "searches in json files")
    parser.add_argument("--url", help="Elasticsearch URL. E.g. " +
                        "http://localhost:9200.", required=True)
    parser.add_argument("--dir", help="Output directory", default="saved")
    parser.add_argument("--index", help="Kibana index", default=".kibana")

    args = parser.parse_args()

    es = Elasticsearch(args.url)
    dump_objects(es, args.dir, args.index, "dashboard")
    dump_objects(es, args.dir, args.index, "visualization")
    dump_objects(es, args.dir, args.index, "search")
    dump_objects(es, args.dir, args.index, "index-pattern")

if __name__ == "__main__":
    main()
