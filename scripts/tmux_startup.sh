show_help () {
    cat << EOF
Usage: $(basename "$0") [-s] [-d]
Starts up tmux in one of two set ups, or blank if nothing provided
For vertically split, provide -v
For horizontally split, please provide -h
EOF
}

while getopts ":hvs" opt ; do
    case $opt in
        v) vertical="true" ;;
        s) horizontal="true";;
        h) show_help ; exit 0 ;;
        *) echo "Invalid opt $opt" ; exit 1 ;;
    esac
done

if [ -n "$horizontal" ] ; then
    tmux new-session -d
    tmux split-window -v
    tmux split-window -h
    tmux select-pane -t 0
    tmux resize-pane -D 3
elif [ -n "$vertical" ] ; then
    tmux new-session -d
    tmux split-window -h
    tmux select-pane -t 1
    tmux split-window -v
    tmux select-pane -t 0
    tmux resize-pane -R 3
else
    tmux new-session -d
fi

tmux attach -d -t 0
