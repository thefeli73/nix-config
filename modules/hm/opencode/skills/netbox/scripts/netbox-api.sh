#!/usr/bin/env bash
#
# NetBox API helper script
# Usage: netbox-api.sh <instance> <endpoint> [method] [data]
#
# Instances: brainmill, csbnet, chsfg
# Methods: GET (default), POST, PUT, PATCH, DELETE
#

set -euo pipefail

# Color output helpers
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

error() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

warn() {
    echo -e "${YELLOW}Warning: $1${NC}" >&2
}

# Validate arguments
if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <instance> <endpoint> [method] [data]"
    echo ""
    echo "Instances:"
    echo "  brainmill  - netbox.brainmill.com"
    echo "  csbnet     - netbox.csbnet.se"
    echo "  chsfg      - netbox.chsfg.se"
    echo ""
    echo "Examples:"
    echo "  $0 brainmill /api/dcim/devices/"
    echo "  $0 csbnet /api/ipam/ip-addresses/?address=10.0.1.1"
    echo "  $0 chsfg /api/dcim/devices/ POST '{\"name\":\"new-device\"}'"
    exit 1
fi

INSTANCE="$1"
ENDPOINT="$2"
METHOD="${3:-GET}"
DATA="${4:-}"

# Map instance name to URL and token variable
case "$INSTANCE" in
    brainmill|brainmill.com)
        BASE_URL="https://netbox.brainmill.com"
        TOKEN_VAR="NETBOX_TOKEN_BRAINMILL"
        ;;
    csbnet|csbnet.se)
        BASE_URL="https://netbox.csbnet.se"
        TOKEN_VAR="NETBOX_TOKEN_CSBNET"
        ;;
    chsfg|chsfg.se)
        BASE_URL="https://netbox.chsfg.se"
        TOKEN_VAR="NETBOX_TOKEN_CHSFG"
        ;;
    *)
        error "Unknown instance: $INSTANCE. Valid instances: brainmill, csbnet, chsfg"
        ;;
esac

# Get the token - try instance-specific first, then fallback to generic
TOKEN="${!TOKEN_VAR:-}"
if [[ -z "$TOKEN" ]]; then
    TOKEN="${NETBOX_TOKEN:-}"
fi

if [[ -z "$TOKEN" ]]; then
    error "No API token found. Set $TOKEN_VAR or NETBOX_TOKEN environment variable."
fi

# Ensure endpoint starts with /
if [[ ! "$ENDPOINT" =~ ^/ ]]; then
    ENDPOINT="/$ENDPOINT"
fi

# Build the full URL
URL="${BASE_URL}${ENDPOINT}"

# Build curl arguments
CURL_ARGS=(
    -s
    -X "$METHOD"
    -H "Authorization: Token $TOKEN"
    -H "Content-Type: application/json"
    -H "Accept: application/json"
)

# Add data for POST/PUT/PATCH
if [[ -n "$DATA" && "$METHOD" != "GET" && "$METHOD" != "DELETE" ]]; then
    CURL_ARGS+=(-d "$DATA")
fi

# Make the request
HTTP_RESPONSE=$(curl "${CURL_ARGS[@]}" -w "\n%{http_code}" "$URL" 2>&1) || {
    error "Failed to connect to $URL"
}

# Split response body and status code
HTTP_BODY=$(echo "$HTTP_RESPONSE" | sed '$d')
HTTP_STATUS=$(echo "$HTTP_RESPONSE" | tail -n1)

# Handle response based on status code
case "$HTTP_STATUS" in
    200|201)
        # Success - pretty print JSON if jq is available
        if command -v jq &> /dev/null; then
            echo "$HTTP_BODY" | jq .
        else
            echo "$HTTP_BODY"
        fi
        ;;
    204)
        # No content (successful DELETE)
        echo -e "${GREEN}Success: Object deleted${NC}"
        ;;
    400)
        echo -e "${RED}Bad Request (400):${NC}" >&2
        if command -v jq &> /dev/null; then
            echo "$HTTP_BODY" | jq . >&2
        else
            echo "$HTTP_BODY" >&2
        fi
        exit 1
        ;;
    401)
        error "Unauthorized (401): Invalid or missing API token"
        ;;
    403)
        error "Forbidden (403): Token lacks permission for this operation"
        ;;
    404)
        error "Not Found (404): $URL"
        ;;
    429)
        error "Rate Limited (429): Too many requests. Please wait and try again."
        ;;
    5*)
        error "Server Error ($HTTP_STATUS): NetBox returned an error. Check if the service is healthy."
        ;;
    *)
        error "Unexpected status code: $HTTP_STATUS\n$HTTP_BODY"
        ;;
esac
