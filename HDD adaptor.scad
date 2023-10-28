/*
HDD adaptor - A HDD Adaptor for the HP DeskPro 600 Gen 1
Copyright (C) 2023 nomike

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

// This is a OpenSCAD file to generate the bed for the HP DeskPro 600 Gen 1 HDD Adaptor

// == common customizer variables ==
drive_heigth = 7; // The height of the drive in mm. Only relevant if you want to stack another adaptor on top of this one. Typical values are: 5mm, 7mm, 9.5mm, 12.5mm, 15mm, 19mm

sliders = "small"; // "big", small", or "none"

// == further twekable variables - won't harm the adaptor if you change them, but you probably don't need to ==
bed_heigth = 2; // Adds further stability but also increases the height of the adaptor. 2mm should be fine.
wall_width = 7; // 7mm should be fine. More just increases the print time and filament usage.

drive_connecting_screwhead_heigth = 2.5; // The heigth of the screwhead of the drive. Only relevant if you want to stack another adaptor on top of this one.

// Cutout at the connector side of the drive. Saves material and print time and allows access to the connector.
cutout1_length = 45;
cutout1_width = 45;

// This just saves material and print time. If you make it too big, the adapter loses regidity.
cutout2_length = 35;
cutout2_width = 28;
cutout2_x_offset = 41;

// Further save material and print time.
cutout3_length1 = 17;
cutout3_width2 = 34;

// The offset of the drive mount holes from the back side of the drive. Puts three holes on the adapter to allow for different mounting positions.
drive_hole_x_offset = 3.9 + (cutout3_length1 / 2);
drive_hole_x_spacing = 4.5;

$fn = 21; // The number of facets for the cylinders. 21 should be fine. More just increases the print time and filament usage.

// == constants - if you change them, the adaptor will probably not fit anymore ==
width = 101.6; // 4 inches; see https://en.wikipedia.org/wiki/List_of_disk_drive_form_factors#List
length = 146.05; // 5.75 inches; see https://en.wikipedia.org/wiki/List_of_disk_drive_form_factors#List 

drive_hole_diameter = 3.9; // Fits a standard M2.5 screw including a little bit of wiggle room

drive_hole_x_distance = 76.6; // see https://wiki.geekworm.com/2.5_inch_Hard_Drive
drive_hole_y_distance = 61.72; // see https://wiki.geekworm.com/2.5_inch_Hard_Drive

big_slider_small_diameter = 8;
big_slider_big_diameter = 12;

big_slider_small_heigth = 4.7;
big_slider_big_heigth = 2.5;

big_slider_offset = 9.7 + (big_slider_big_diameter / 2);
big_slider_distance = 88.6;

small_slider_diameter = 6.9;
small_slider_heigth = 3;

small_slider_offset = 11;
small_slider_distance = 82.4;

connecting_nut_diameter = 6.5;
connecting_nut_heigth = 3;
connecting_screwhead_diameter = 6;
connecting_screwhead_heigth = 2.5;


// internal calculated values
_heigth = drive_heigth + bed_heigth + drive_connecting_screwhead_heigth;
_cutout3_y_inner_offset = (width / 2) - (cutout3_width2 / 2);
_angle_side = sqrt(pow(cutout3_length1 / 2, 2) / 2);

union() {
    difference() {
        union() {
            // wall 1 
            cube([length, wall_width, _heigth]);
            // wall 2
            translate([0, width - wall_width, 0]) cube([length, wall_width, _heigth]);

            // bed
            cube([length, width, bed_heigth]);
        }
        // cutout1
        translate([length - cutout1_length, (width - cutout1_width) / 2, 0]) cube([cutout1_length, cutout1_width, bed_heigth]);
        // coutout 2a
        translate([cutout2_x_offset, wall_width, 0]) cube([cutout2_length, cutout2_width, bed_heigth]);

        // cutout 2b
        translate([cutout2_x_offset, width - wall_width - cutout2_width, 0]) cube([cutout2_length, cutout2_width, bed_heigth]);

        // cutout 3
        union() {
            translate([0, (width / 2) - (cutout3_width2 / 2), 0]) cube([cutout3_length1, cutout3_width2, bed_heigth]);
            translate([0, (width / 2) - ((width - (4 * wall_width)) / 2), 0]) cube([cutout3_length1 / 2, width - (4 * wall_width), bed_heigth]);
        }

        // drive mount holes
        for (i = [0 : 1 : 2]) {
            union() {
                offset = drive_hole_x_offset + ((drive_hole_x_spacing + drive_hole_diameter) * i);
                translate([offset, (width - drive_hole_y_distance) / 2, 0]) cylinder(h = bed_heigth, d = drive_hole_diameter);
                translate([offset, width - ((width - drive_hole_y_distance) / 2), 0]) cylinder(h = bed_heigth, d = drive_hole_diameter);
                translate([offset + drive_hole_x_distance, (width - drive_hole_y_distance) / 2, 0]) cylinder(h = bed_heigth, d = drive_hole_diameter);
                translate([offset + drive_hole_x_distance, width - ((width - drive_hole_y_distance) / 2), 0]) cylinder(h = bed_heigth, d = drive_hole_diameter);
            }
        }

        // slopes
        translate([cutout3_length1 / 2, _cutout3_y_inner_offset, 0]) rotate([0, 0, 45]) cube([5, 5, bed_heigth * 2], center = true);
        translate([cutout3_length1 / 2, _cutout3_y_inner_offset + cutout3_width2, 0]) rotate([0, 0, 45]) cube([5, 5, bed_heigth * 2], center = true);

        translate([0, wall_width + (_angle_side), 0]) rotate([0, 0, 45]) cube([_angle_side, _angle_side, bed_heigth * 2], center = true);
        translate([0, wall_width + (_angle_side) + width - (4 * wall_width), 0]) rotate([0, 0, 45]) cube([_angle_side, _angle_side, bed_heigth * 2], center = true);

        // connect holes
        for(x_offset = [39, 102]){
            for(y_offset = [0, width - wall_width]) {
                translate([x_offset + (drive_hole_diameter / 2), y_offset + wall_width / 2, 0]) cylinder(h=_heigth, d=drive_hole_diameter);
                translate([x_offset + (drive_hole_diameter / 2), y_offset + wall_width / 2, 0]) cylinder($fn=6, h=connecting_nut_heigth, d=connecting_nut_diameter);
                translate([x_offset + (drive_hole_diameter / 2), y_offset + wall_width / 2, _heigth - connecting_screwhead_heigth]) cylinder(h=connecting_screwhead_heigth, d=connecting_screwhead_diameter);
            }
        }
    }
}

// sliders
if (sliders == "big") {
    for (offset = [big_slider_offset, big_slider_offset + big_slider_big_diameter + big_slider_distance]) {
        union() {
            translate([offset, 0, big_slider_big_diameter / 2]) rotate([90, 0, 0]) cylinder(h = big_slider_small_heigth, d = big_slider_small_diameter);
            translate([offset, 0, big_slider_big_diameter / 2]) rotate([90, 0, 0])  cylinder(h = big_slider_big_heigth, d = big_slider_big_diameter);
            translate([offset, width, big_slider_big_diameter / 2]) rotate([-90, 180, 0]) cylinder(h = big_slider_small_heigth, d = big_slider_small_diameter);
            translate([offset, width, big_slider_big_diameter / 2]) rotate([-90, 180, 0])  cylinder(h = big_slider_big_heigth, d = big_slider_big_diameter);
        }
    }
} else if (sliders == "small") {
    for (offset = [small_slider_offset, small_slider_offset + small_slider_diameter + small_slider_distance]) {
        union() {
            translate([offset, 0, small_slider_diameter / 2]) rotate([90, 0, 0]) cylinder(h = small_slider_heigth, d = small_slider_diameter);
            translate([offset, width, small_slider_diameter / 2]) rotate([-90, 180, 0]) cylinder(h = small_slider_heigth, d = small_slider_diameter);
        }
    }

}
