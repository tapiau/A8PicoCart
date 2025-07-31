
module cart_bottom_logo(cart_width, cart_shell_thickness) {
    translate([4,cart_width/2,cart_shell_thickness-0.4])
        rotate([0,0,-90])
            linear_extrude(0.4, convexity = 4)
            resize([cart_width - 4*cart_shell_thickness,0])
                text("A8PicoCart", halign = "center");
}

if(is_undef(CONFIG)) {
    include <../config.scad>;
    cart_bottom_logo(cart_width, cart_shell_thickness);
}
