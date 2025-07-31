include <config.scad>;

include <main_shell.scad>;
include <pcb_support.scad>;
include <screw_tower.scad>;
include <cart_bottom_logo.scad>;

$fn=40;

module cart_bottom(cart_length, cart_width, cart_height) {
    difference() {
        union() {
            // main shell
            main_shell(cart_length, cart_width, cart_height_bottom, cart_shell_thickness, rim_height, ridge_width);
            // screw holes
            translate([31, (cart_width-screw_sep)/2, 0])
                screw_tower_bottom(cart_height-rim_height);
            translate([31, cart_width-(cart_width-screw_sep)/2, 0])
                screw_tower_bottom(cart_height-rim_height);
        }

        translate([screw_tower_offset, (cart_width-screw_sep)/2, 0])
            screw_tower_bottom_sub(cart_height);
        translate([screw_tower_offset, cart_width-(cart_width-screw_sep)/2, 0])
            screw_tower_bottom_sub(cart_height);
    }
}

difference() {
    cart_bottom(cart_length, cart_width, cart_height_bottom);
    cart_bottom_logo(cart_width, cart_shell_thickness);
}
