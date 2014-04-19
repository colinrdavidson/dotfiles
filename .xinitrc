#set the cursor
xsetroot -cursor_name left_ptr

#swap caps
xmodmap ~/.swapCAPS.xmodmap

#load .Xresources
xrdb ~/.Xresources

#start xmonad
exec xmonad

#set wallpaper with feh
#feh --bg-scale ~/media/wallpaper/mandelbrot.jpeg
