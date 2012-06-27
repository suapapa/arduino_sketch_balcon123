# balcon123 - 3 Foot switch witch mapped F2, F3, F4

Arduino sketch to made DIY foot controller.

![balcon123_pedals](https://github.com/suapapa/arduino_sketch_balcon123/blob/master/pic/balcon123_pedals.jpg?raw=true)

By using Arduino as USB-HID, can makes bind a key to release easier and,
also, can expend to three pedals with minimal cost.
Only one usb slot used for three pedals.

![balcon123_in_box](https://github.com/suapapa/arduino_sketch_balcon123/blob/master/pic/balcon123_in_box.jpg?raw=true)

The [pedal](http://ibuy.kr/iAiAUWa) I used is only -about- $2 for each in Korea. :)

## History

It inspired from [Vim-clucth](https://github.com/alevchuk/vim-clutch) by alevchunk.

I want use the fadals not only for vim but also for another programs e.g.
desktop screen switching by same meta-key combination for vim for map
and desktop manager to use keyboard shortcut.

At first, I planned map those three pedals to `Ctrl-1`, `Ctrl-2`, `Ctrl-3`.
But, found it's hard to use `Ctrl` with number key for map in vimrc.
And, changed the plan to use `Ctrl-{F1|F2|F3}`. It works for vim.
But, after I also bind those key to desktop screen switching, key-maps in vim
ignored (only screen switching is working). :(

So, changed plan to use `F2`, `F3`, `F4` without `Ctrl`.
Map them to `I`, `i`, `A` for vim. and,
for desktop switching, use them with `Ctrl`.

It's fun and handy! Thanks to alevchunk for this greate idea.

## Get source

Should clone this project to directory, balcon123. It's name of the sketch.

    $ git clone https://github.com/suapapa/arduino_sketch_balcon123.git balcon123

Update submodule to import UsbKeyboard library.

    $ git submodule init
    $ git submodule update


## Build sketch

Can use scons to build it.
I made a script `build.sh` to specify mcu and, etc...

    $ ./build.sh

If you have problem with scons,
check [arscons](https://github.com/suapapa/arscons.git)'s wiki
for the guide.


## Use for Vim

Insert following maps to `~/.vimrc`

    map <F2> I
    map <F3> i
    map <F4> A

## Use for desktop switching

- Map `Ctrl-F2`, `Ctrl-F4` to desktop screen switching to left and right
- Map `Ctrl-F3` for show desktop
