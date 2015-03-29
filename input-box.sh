#!/bin/sh
# The MIT License (MIT)
#
# Copyright (c) 2015 Star Brilliant <olinlinlino@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

Title="中文聊天辅助输入工具"
eval $(xdotool getmouselocation --shell)

which zenity &>/dev/null || (echo '错误：zenity 程序未安装。' >&2; exit 2)
which xclip &>/dev/null || (echo '错误：xclip 程序未安装。' >&2; zenity --error --text '错误：xclip 程序未安装' --titie "$Title"; exit 2)
which xdotool &>/dev/null || (echo '错误：xdotool 程序未安装。' >&2; zenity --error --text '错误：xdotool 程序未安装' --title "$Title"; exit 2)

_chat_input=$(zenity --text-info --editable --width 270 --height 320 --title "$Title")
test -z "$_chat_input" && exit 0
echo "$_chat_input" | perl -pe 'chomp if eof' | xclip -selection c

xdotool mousemove --sync $X $Y &&  xdotool click 1 && xdotool key Control_L+v && xdotool key Return
