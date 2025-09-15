ffmpeg -f lavfi -i "
color=white:1280x720:d=10,
format=rgb24,
drawtext=
  fontcolor=black:
  fontsize=600:
  text='%{eif\:mod(600-t, 10)\:d\:2}':
  x=(w-text_w)/2:
  y=(h-text_h)/2
" 10second.mp4
