# be5flf

A FIGlet font suitable as a banner font in VSCode. By be5invis. I just made this a `.flf` file.

*The following are just some notes, not proper documentation. Sorry.*

See [this wonderful document](http://www.jave.de/figlet/figfont.html) for more information on FIGlet fonts.


## Format of `be5flf.txt`

- Any number of FLF data lines that are not just `$`
- A single terminating `$`
- A number of glyphs
    - The character, and a single `$`
    - Lines of the glyph, each followed by a single `$`
    - A single terminating `$`

Non-header (data) lines are terminated with `$` for clarity.

An empty line is added to each glyph so that multi-line text will be readable. This may change.

If a required character is not present, an empty glyph of height 5 is emitted. This may change.

Currently, non-required FIGlet characters are simply ignored. This may change.

Please refer to this section in [the wonderful document](http://www.jave.de/figlet/figfont.html#requiredfigchar) to see the list of required characters.

A short example:

```
Example be5flf
madoka madoka madoka
$
A$
  #  $
 # # $
#   #$
#####$
#   #$
$
B$
#### $
#   #$
#### $
#   #$
###  $
$
```

## Usage of `proc.hs`

```
stack proc.hs < be5flf.txt > be5.flf
```