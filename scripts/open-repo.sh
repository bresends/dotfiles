#!/usr/bin/env bash

cd "$(tmux display-message -p '#{pane_current_path}')"
url=$(git remote get-url origin)

if [[ $url == *github.com* ]]; then
	if [[ $url == git@* ]]; then
		url="${url#git@}"
		url="${url/://}"
		url="${url%.git}"
		url="https://$url"
	fi
	xdg-open "$url" 2>/dev/null &
else
	echo "This repository is not hosted on GitHub"
fi
