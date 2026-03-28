#!/bin/bash
# Creates N even columns side by side.
# Usage: workspace-columns.sh [num_columns]

n=${1:-2}

if [ "$n" -lt 1 ]; then
    exit 1
fi

for ((i=1; i<n; i++)); do
    # Current pane counts as first column, so create n-1 more
    tmux split-window -h -c "#{pane_current_path}"
done

tmux select-layout even-horizontal
tmux select-pane -t 0
