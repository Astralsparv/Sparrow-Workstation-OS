# Sparrow Workstation OS

## What is it?

Sparrow Workstation OS is a fantasy workstation, developed by @astralsparv.

This was developed in C and Lua.

## Contact

You can contact me and anyone else involved in this through the [discord server](https://discord.gg/TuwPjjCuwK).

There is development discussions that will be held here that you may contribute to.

## Releases

This is *not* released in any setting as of writing this, a date for any release is unknown.

Releases will start in small close releases to private groups for testing, before leading to a public release.

## Source code

I'm not yet sure whether the C-side will be open sourced or closed source; select few people will have access to source code.

For now, the `/system` code is available for viewing, but not licensed for use.

If, for whatever reason, you are interested in making use of it; contact me.

## Notes

All information here is prone to change, some more than others.

There are some markings in here to add extra information.

`<!>` Not yet implemented
`<->` Somewhat implemented
`<?>` Not final, prone to change

## Hardware Specs

The Sparrow Workstation has a CPU with 16,000 instructions per second; this is shared between the entire OS. `<->`

The Sparrow Workstation can have infinite processes, each process has:

* 16MB of addressable peek/poke meomry
* 64MB of Lua memory `<!>`
* 16K IPS (shared between processes) `<->`
* 256 Adjustable Color Palette `<->`

## Addressable Memory Layout

The Sparrow Workstation has 16MB of addressable memory with `peek` and `poke`.

### 0x000000 - 0x01FA40
480x270 Display
Each pixel = 1 byte (0-255)

### 0x01FB00 - 0x01FB80

Controller Data (128 bytes, 16 bytes/player, 8 players)

```
0 left
1 right
2 up
3 down
4 x
5 z
6 select
7 start
8 RESERVED
9 RESERVED
a RESERVED
b RESERVED
c RESERVED
d RESERVED
e RESERVED
f RESERVED
```

### 0x01FC00 - 0x119C00 (palette of 256 cols) `<->`

### 0x120011 - 0x1400B0
Font data
256 characters; 32 bytes/character

0x120011 - width of top 128 chars [characters] (max 16)
0x120012 - height of chars (max 16)
0x120013 - width of bottom 128 chars [symbols] (max 16)
0x120014 - tab width (px) `<!>`

0x120020 - 0x1200A0 - 256 nibbles (4 bits) of data; each being adjustment of character width by +-8px, nibble is signed with bit 1

0x1200B0 - 0x1400B0 (raw character bitmaps, 32 bytes / character)
