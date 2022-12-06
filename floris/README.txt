Download and extract npiet, the Piet interpreter.
I've tested on Windows with the binaries that are available on the website: http://www.bertnase.de/npiet/npiet-1.3a-win32.zip
Source code is also available on: http://www.bertnase.de/npiet/

To execute:

npiet -q aoc.png < input.txt

Note: the last line of the input.txt needs to end with an EOL character before the EOF in order for it to parse it correctly. Official AoC input works like this, but this is good to keep in mind if you have your own input files.
