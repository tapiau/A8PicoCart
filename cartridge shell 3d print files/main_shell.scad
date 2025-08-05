/* A8PicoCart shell
   (c) R.Edwards 2023
*/

include <ridges.scad>
include <pcb_support.scad>

module main_shell(cart_length, cart_width, cart_height, cart_shell_thickness, rim_height, ridge_width) {
    shell_height = cart_height - (rim_height > 0 ? rim_height : 0);
    
    difference() {
        // main shell
        union() {
            cube([cart_length, cart_width, shell_height]);
            translate([0, cart_shell_thickness/2, shell_height]) 
                cube([cart_length-cart_shell_thickness/2, cart_width-cart_shell_thickness, rim_height]);
        }
        // rims
        translate([0, cart_shell_thickness/2, shell_height+rim_height])
            cube([cart_length-cart_shell_thickness/2,
                cart_width-cart_shell_thickness, -rim_height]);
        // make hollow
        translate([0, cart_shell_thickness, cart_shell_thickness])
            cube([
                cart_length-cart_shell_thickness,
                cart_width-cart_shell_thickness*2,
                shell_height-cart_shell_thickness+10
            ]);
    }    
    echo("main_shell::ridge_width",ridge_width);
    ridges(cart_length, cart_width, shell_height, ridge_width);
    pcb_support(cart_width, shell_height + rim_height, cart_shell_thickness, rim_height>0);
}

//if(is_undef(CONFIG)) {
if(false) {
    include <config.scad>
    main_shell(cart_length, cart_width, cart_height_top , cart_shell_thickness, -rim_height, ridge_width);
    translate([0,-70,0]) main_shell(cart_length, cart_width, cart_height_bottom, cart_shell_thickness, rim_height, ridge_width);
}
