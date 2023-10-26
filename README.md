# HDD Adaptor

This project contains an OpenSCAD model of a 2.5" to 3.5" HDD adaptor.

The adaptor is designed to fit a 2.5" HDD into a 3.5" HDD slot. Sliders could be generated which will fit into a HP ProDesk 600 G1 computer case. Multiple adaptors could be stacked and screwed together to fit multiple 2.5" HDDs into a single 3.5" HDD slot.

The model is parametric and can be adjusted to fit other cases.

## Print settings

Infill: 10%
Supports: no
Rafts: no
Material: PLA, PETG, ABS, etc.

**Note:** Even though I read somewhere that PLA is not suitable for HDD adaptors due to disks getting hot and PLA not being able to withstand the heat, I have been using PLA so far and haven't noticed any issues. I'm running a NAS where the disks are around 30°C in a room with ~20°C. And even on hot summer days the disks won't get near to any temperature where PLA would start to soften. PLA will begin to deform or warp at 60-65°C. Most HDDs are rated for 50°C, some for up to 60°C. So PLA should be fine for most use cases.

## Usage

Just run `make` to generate files for all common HDD thicknesses and with all supported slider types.

## Mounting

You should use M3 screws to mount the HDD to the adaptor. The screws should be 5mm long.

To connect two adaptors together you should use M2.5 cylinder-head screws and nuts. The length of those screws depends on the adapter height. The screwheads of the HDD mounting screw will pertrude from the underside of the adaptors. This has been accomodated by the design to allow enough space for stacking.

The top-most adapter could use the lowest profile version to save on filament and print time.

## License

The design is re-implementation of [Simplified universal 2.5 > 3.5 hdd / sdd caddy](https://www.thingiverse.com/thing:656966) created by [kentronix](https://www.thingiverse.com/kentronix) and published under the [Creative Commons - Attribution - Share Alike license](https://creativecommons.org/licenses/by-sa/3.0/).

This project uses the GPLv3 license. See https://wiki.creativecommons.org/wiki/ShareAlike_compatibility:_GPLv3 for information about the compatibility of the licenses.

## Copyright
Copyright (C) 2023 nomike
http://github.com/nomike/HDD-Adaptor
