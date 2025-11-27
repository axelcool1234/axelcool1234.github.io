#!/usr/bin/env python3
import argparse, json, time, os

parser = argparse.ArgumentParser()
parser.add_argument('--out', required=True)
args = parser.parse_args()

os.makedirs(os.path.dirname(args.out), exist_ok=True)
payload = {
    "generated_at": int(time.time()),
    "message": "Hello from my-experiment generator",
    "items": [1, 1, 2, 3, 5, 8]
}
with open(args.out, 'w') as f:
    json.dump(payload, f)
print(f"wrote {args.out}")

