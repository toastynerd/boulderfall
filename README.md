# Boulderfall

A single screen homebrew game for NES. Made to run on the 
nrom cartridge archetecture, everything is in here. All
of this has only been tested on Arch linux, additional
work would most likely be required to run a build on another
system but the rom itself is also included if you don't have
a need/desire to build it yourself. 

## Building
To build simply run `make` this will create boulderfall.nes 
which should work with most emulators.

## Running on hardware
There are two pieces I use to run this on hardware, not counting your NES. First you
need the cartridge programmer which can be found [here](http://www.infiniteneslives.com/inlretro.php).
Second you'll need a [cartridge case](http://www.infiniteneslives.com/nessupplies.php#cases) 
and an [NROM board](http://www.infiniteneslives.com/nessupplies.php#NROM).

You'll need [my fork](https://gitlab.com/toastynerd/INL-retro-progdump) of the [official](https://gitlab.com/InfiniteNesLives/INL-retro-progdump) INL-Retro
software as it has some additional code that helps with pathing on linux.

There are then a few env variables you'll need to set first `INL_PATH` needs
to be set to the host folder in the INL-retro-progdump codebase. After that,
you'll want to setup a lua path like this: `export LUA_PATH=';;'$INL_PATH'/?.lua'`
or `export LUA_PATH=$LUA_PATH:$INL_PATH'/?.lua'` depending on if you already
have a lua path setup.

After all that is setup a `make cartridge` command should write the rom
to the cart, assuming you have everything setup correctly.
