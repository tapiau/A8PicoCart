include <main_shell.scad>;
include <screw_tower.scad>;

$fn=40;

module cart_bottom(cart_length, cart_width, cart_height, cart_shell_thickness, screw_tower_offset, screw_sep, ridge_width, rim_height) {
    difference() {
        union() {
            // main shell
            main_shell(cart_length, cart_width, cart_height, cart_shell_thickness, rim_height, ridge_width);            
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

if(is_undef(CONFIG)) {
    include <config.scad>
    cart_bottom(cart_length, cart_width, cart_height_bottom, cart_shell_thickness, screw_tower_offset, screw_sep, ridge_width, rim_height);
}
