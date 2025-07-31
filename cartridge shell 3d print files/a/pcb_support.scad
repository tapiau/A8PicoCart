/* A8PicoCart shell
   (c) R.Edwards 2023
*/


module pcb_support(cart_width, cart_height, cart_shell_thickness, usb_slot=false) {
    pcb_width=55;
    pcb_cutout=1;
    usb_slot_widht=17;
    support_offset_1=17;
    support_offset_2=58;
    support_width_2=12;
    
    difference() {
        union() {
            translate([support_offset_1, cart_shell_thickness, 0])
                cube([cart_shell_thickness, cart_width-cart_shell_thickness*2, cart_height]);
            translate([support_offset_2, cart_shell_thickness, 0])
                cube([cart_shell_thickness, support_width_2-cart_shell_thickness, cart_height]);
            translate([support_offset_2, cart_width-support_width_2, 0])
                cube([cart_shell_thickness, support_width_2-cart_shell_thickness, cart_height]);
        }

        // pcb_cutout
        translate([cart_shell_thickness, (cart_width-pcb_width)/2, cart_height-pcb_cutout])
            cube([support_offset_2, pcb_width, cart_height-pcb_cutout]);

        // usb_slot        
        if(usb_slot) {
            translate([0, (cart_width-usb_slot_widht)/2, 0])
                cube([40, usb_slot_widht, cart_height]);
        }
    }
}


//if(is_undef(CONFIG)) {
//    include <config.scad>
//    pcb_support(cart_width, cart_height_top, cart_shell_thickness, true);
//}
