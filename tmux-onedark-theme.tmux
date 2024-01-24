#!/bin/bash

# styles based on https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/palette.lua
onedark_style="warmer"

case $onedark_style in
   "warmer")
      echo "loading warmer theme"
      onedark_black="#232326"
      onedark_darker="#1b1c1e"
      onedark_blue="#57a5e5"
      onedark_yellow="#dbb671"
      onedark_red="#de5d68"
      onedark_white="#a7aab0"
      onedark_green="#8fb573"
      onedark_visual_grey="#37383d"
      onedark_comment_grey="#5a5b5e"
      onedark_light_grey="#818387"
      ;;
   "*")  # default to dark
      echo "loading dark theme"
      onedark_black="#282c34"
      onedark_darker="#21252b"
      onedark_blue="#61afef"
      onedark_yellow="#e5c07b"
      onedark_red="#e86671"
      onedark_white="#aab2bf"
      onedark_green="#98c379"
      onedark_visual_grey="#3b3f4c"
      onedark_comment_grey="#5c6370"
      onedark_light_grey="#848b98"
      ;;
esac

get() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"

   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
   fi
}

set() {
   local option=$1
   local value=$2
   tmux set-option -gq "$option" "$value"
}

setw() {
   local option=$1
   local value=$2
   tmux set-window-option -gq "$option" "$value"
}

set "status" "on"
set "status-justify" "left"

set "status-left-length" "100"
set "status-right-length" "100"
set "status-right-attr" "none"

set "message-fg" "$onedark_white"
set "message-bg" "$onedark_black"

set "message-command-fg" "$onedark_white"
set "message-command-bg" "$onedark_black"

set "status-attr" "none"
set "status-left-attr" "none"

setw window-status-style "fg=${onedark_black},bg=${onedark_black},none"
setw window-status-activity-style "fg=${onedark_black},bg=${onedark_black},none"

setw "window-status-separator" ""
setw "clock-mode-colour" "$onedark_comment_grey"

set window-style "fg=${onedark_light_grey},bg=${onedark_darker}"
set window-active-style "fg=${onedark_white},bg=${onedark_darker}"

set pane-border-style "fg=${onedark_comment_grey},bg=${onedark_darker}"
set pane-active-border-style "fg=${onedark_yellow},bg=${onedark_darker}"

set "display-panes-active-colour" "$onedark_red"
set "display-panes-colour" "$onedark_blue"

set "status-bg" "$onedark_black"
set "status-fg" "$onedark_white"

set "@prefix_highlight_fg" "$onedark_black"
set "@prefix_highlight_bg" "$onedark_yellow"
set "@prefix_highlight_copy_mode_attr" "fg=$onedark_black,bg=$onedark_yellow"
set "@prefix_highlight_output_prefix" "  "

status_widgets=$(get "@onedark_widgets")
time_format=$(get "@onedark_time_format" "%R")
date_format=$(get "@onedark_date_format" "%d/%m/%Y")

set "status-right" "#[fg=$onedark_white,bg=$onedark_black,nounderscore,noitalics]${time_format}  ${date_format} #[fg=$onedark_visual_grey,bg=$onedark_black]#[fg=$onedark_visual_grey,bg=$onedark_visual_grey]#[fg=$onedark_white, bg=$onedark_visual_grey]${status_widgets} #[fg=$onedark_yellow,bg=$onedark_visual_grey,nobold,nounderscore,noitalics]#[fg=$onedark_black,bg=$onedark_yellow,bold] #h  "
set "status-left" "#[fg=$onedark_black,bg=$onedark_yellow,bold] #S #{prefix_highlight}#[fg=$onedark_yellow,bg=$onedark_black,nobold,nounderscore,noitalics]"

set "window-status-format" "#[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]#[fg=$onedark_white,bg=$onedark_black] #I  #W [#(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev)] #[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]"
set "window-status-current-format" "#[fg=$onedark_black,bg=$onedark_visual_grey,nobold,nounderscore,noitalics]#[fg=$onedark_white,bg=$onedark_visual_grey,nobold] #I  #W [#(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev)] #[fg=$onedark_visual_grey,bg=$onedark_black,nobold,nounderscore,noitalics]"
