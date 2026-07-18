unavailable() {
  printf '%s\n' '{"text":"󰚩 …","tooltip":"Codex usage unavailable","class":"unavailable"}'
}

codexbar_bin="${CODEXBAR_BIN:-codexbar}"

if ! usage_json="$(timeout --kill-after=5s 25s "$codexbar_bin" usage \
  --provider codex \
  --source oauth \
  --format json \
  --no-color)"; then
  unavailable
  exit 0
fi

jq --argjson current_time "${CODEXBAR_NOW:-null}" -ce '
  def current_time: $current_time // now;

  def remaining:
    (100 - .)
    | if . < 0 then 0 elif . > 100 then 100 else . end
    | floor;

  def seconds_until($timestamp):
    try (($timestamp | fromdateiso8601) - current_time | floor) catch null;

  def duration($seconds):
    if $seconds >= 86400 then
      "\(($seconds / 86400) | floor)d \((($seconds % 86400) / 3600) | floor)h"
    elif $seconds >= 3600 then
      "\(($seconds / 3600) | floor)h \((($seconds % 3600) / 60) | floor)m"
    else
      "\([(($seconds / 60) | ceil), 1] | max)m"
    end;

  def reset_status($timestamp):
    seconds_until($timestamp) as $seconds
    | if $seconds == null then "reset unknown"
      elif $seconds <= 0 then "reset due"
      else "resets in \(duration($seconds))"
      end;

  first
  | select(.error == null)
  | .usage as $usage
  | (if ($usage.primary.usedPercent | type) == "number" then ($usage.primary.usedPercent | remaining) else null end) as $five_hour
  | (if ($usage.secondary.usedPercent | type) == "number" then ($usage.secondary.usedPercent | remaining) else null end) as $weekly
  | ([$five_hour, $weekly] | map(select(. != null))) as $available
  | select($available | length > 0)
  | ($available | min) as $remaining
  | ($usage.codexResetCredits // null) as $reset_credits
  | (if ($reset_credits | type) == "object" and ($reset_credits.credits | type) == "array"
     then [$reset_credits.credits[]
       | select(type == "object" and .status == "available")
       | . as $credit
       | seconds_until($credit.expires_at) as $expiry
       | select($credit.expires_at == null or ($expiry != null and $expiry > 0))]
     else null
     end) as $available_credits
  | ([$available_credits[]?
      | seconds_until(.expires_at)
      | select(. != null and . > 0)] | min // null) as $next_credit_expiry
  | {
      text: "󰚩 \($remaining)%",
      tooltip: (
        "Codex limits\n"
        + (if $five_hour == null then "5-hour: unavailable" else "5-hour: \($five_hour)% remaining · \(reset_status($usage.primary.resetsAt))" end)
        + "\n"
        + (if $weekly == null then "Weekly: unavailable" else "Weekly: \($weekly)% remaining · \(reset_status($usage.secondary.resetsAt))" end)
        + (if $available_credits == null then ""
           else "\nReset credits: \($available_credits | length) available"
             + (if $next_credit_expiry == null then ""
                else "\nNext reset credit expires in \(duration($next_credit_expiry))"
                end)
           end)
      ),
      class: (
        if $remaining <= 10 then "critical"
        elif $remaining <= 20 then "warning"
        else "ok"
        end
      ),
      percentage: $remaining
    }
' <<<"$usage_json" 2>/dev/null || unavailable
