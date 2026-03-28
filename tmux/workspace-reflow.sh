#!/bin/bash
# Rearranges existing panes into columns with 75/25 top/bottom split.
# Pairs panes in order: 0+1 = col1, 2+3 = col2, etc.

pane_ids=($(tmux list-panes -F '#{pane_id}'))
total=${#pane_ids[@]}
win_height=$(tmux display-message -p '#{window_height}')
top_height=$(( win_height * 3 / 4 ))

if [ "$total" -le 1 ]; then
    tmux split-window -v -p 25 -c "#{pane_current_path}"
    tmux select-pane -t 0
    exit 0
fi

# Step 1: Move all panes into a single vertical stack
# by joining each pane below the anchor
for ((i=total-1; i>=1; i--)); do
    tmux move-pane -v -s "${pane_ids[$i]}" -t "${pane_ids[0]}"
done

# Re-read pane IDs after rearrangement
pane_ids=($(tmux list-panes -F '#{pane_id}'))
total=${#pane_ids[@]}

# Step 2: Now all panes are stacked vertically. Rebuild as columns.
# Move pair tops to the right of anchor to form columns.
for ((i=2; i<total; i+=2)); do
    tmux move-pane -h -s "${pane_ids[$i]}" -t "${pane_ids[0]}"
done

# Step 3: Resize top panes to 75% height
pane_ids=($(tmux list-panes -F '#{pane_id}'))
for ((i=0; i<${#pane_ids[@]}; i+=2)); do
    tmux resize-pane -t "${pane_ids[$i]}" -y "$top_height" 2>/dev/null
done

tmux select-pane -t 0
