#!/usr/bin/bash

set -o pipefail

# Consider install 'nerd-fonts' on your system
# this script using icons in rofi menu

declare items=""
declare -A winlists
menu_title='Windows minimized'
re_num='^[0-9]+$'
list_minimized=$(i3-msg -t get_tree 2>/dev/null | jq -r '.nodes[].nodes[].nodes[]|select(.name=="__i3_scratch")|.floating_nodes[].nodes[]|select(.marks[]|contains("minimize"))|((.id|tostring) + " " + .name)' 2>/dev/null)
[[ ! -n ${list_minimized} ]] && { echo "WARNING: There are no windows minimized/hidden, exiting ..."; exit 2; }
while read -r id title; do winlists["$id"]="${title}"; done <<< "$list_minimized"
[ ${#winlists[@]} -gt 1 ] && all_options="舘 \t Show all minimized/hidden windows\n" || all_options=""

show_win() {
        local id=${1}
        [[ ! "$id" =~ $re_num ]] && { echo "ERROR: Windows ID not valid!, exiting ..."; exit 3; }
        i3-msg "[con_id=${id}] scratchpad show"
        i3-msg "[con_id=${id}] focus"
        i3-msg "[con_id=${id}] mark --replace clear"
        i3-msg "[con_id=${id}] unmark clear"
}

for id in "${!winlists[@]}"; do items+="櫓 \t $id \t 🬋🬋🢂 \t  \t ${winlists[$id]}\n"; done; items=${items::-2}
selected=$(printf "${all_options}${items}" | rofi -p "$menu_title" -dmenu -lines 10 -columns 1 | cut -f 2 | xargs)
[ $? -gt 0 ] && { echo "WARNING: No windows selected, ignoring ..."; exit 2; }
[[ $selected =~ $re_num ]] && show_win $selected >/dev/null 2>&1 || for id in "${!winlists[@]}"; do show_win $id >/dev/null 2>&1; done;
