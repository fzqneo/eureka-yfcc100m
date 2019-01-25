#!/bin/bash
set -e

# test AWS CLI credential
aws sts get-caller-identity || (echo "Your AWS credential is not setup properly." >&2; exit 1;)

"$(dirname $0)/sign-cookie.sh"
"$(dirname $0)/start-gui.sh"
