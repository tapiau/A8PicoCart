/* A8PicoCart shell
   (c) R.Edwards 2023
*/

include <main_shell.scad>
include <screw_tower.scad>
include <cart_top_logo.scad>;

module cart_top(cart_length, cart_width, cart_height, cart_shell_thickness, screw_tower_offset, screw_sep, ridge_width, rim_height)
{
    difference() {
        union() {
            main_shell(cart_length, cart_width, cart_height, cart_shell_thickness, -rim_height, ridge_width);            
            
            translate([screw_tower_offset, (cart_width-screw_sep)/2, 0])
                screw_tower_top(cart_height);
            translate([screw_tower_offset, cart_width-(cart_width-screw_sep)/2, 0])
                screw_tower_top(cart_height);
        }    

        // screw holes
        translate([screw_tower_offset, (cart_width-screw_sep)/2, 0])
            screw_tower_top_sub(cart_height);
        translate([screw_tower_offset, cart_width-(cart_width-screw_sep)/2, 0])
            screw_tower_top_sub(cart_height);
        // button
        translate([cart_length-15, 9, 0])
           cylinder(h = cart_shell_thickness, r1 = 2.5, r2 = 2.5,  $fs = 1); 
        // cutout cart port
        translate([0, (cart_width-57)/2, 0])
            cube([10, 57, cart_height]);
    }
}

if(is_undef(CONFIG)) {
    include <config.scad>
    cart_top(cart_length, cart_width, cart_height_top, cart_shell_thickness, screw_tower_offset, screw_sep, ridge_width, rim_height);
}
