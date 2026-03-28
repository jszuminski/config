#!/bin/bash
# Creates a tmux workspace with N columns.
# Each column: top pane (75%) + bottom pane (25%).
# Usage: workspace.sh [num_columns]

n=${1:-2}

if [ "$n" -lt 1 ]; then
    exit 1
fi

# Create n-1 additional columns
for ((i=1; i<n; i++)); do
    tmux split-window -h -c "#{pane_current_path}"
done

# Even out all columns
tmux select-layout even-horizontal

# Split each column vertically (bottom 25%) — right to left to preserve pane indices
for ((i=n-1; i>=0; i--)); do
    tmux select-pane -t "$i"
    tmux split-window -v -p 25 -c "#{pane_current_path}"
done

# Select the top-left pane
tmux select-pane -t 0
