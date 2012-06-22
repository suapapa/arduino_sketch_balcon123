# balcon123 - 3 Foot switch witch mapped Ctrl+1, Ctrl+2, Ctrl+3

This project is Arduino sketch to made DIY foot controller.
Inspired from [Vim-clucth](https://github.com/alevchuk/vim-clutch).

## Get Source

Should clone this project to directory, balcon123. It's name of the sketch.

    $ git clone https://github.com/suapapa/arduino_sketch_balcon123.git balcon123

Update submodule to import UsbKeyboard library.

    $ git submodule init
    $ git submodule update


## Build

Can use scons to build it.
I made a script `build.sh` to specify mcu and, etc...

    $ ./build.sh

If you have problem with scons,
check [arscons](https://github.com/suapapa/arscons.git)'s wiki
for the guide.


## Use for Vim

Insert following to `.vimrc`

    map <C-F1> I
    map <C-F2> a
    map <C-F3> A
    imap <C-F1> <ESC>
    imap <C-F2> <ESC>
    imap <C-F3> <ESC>

