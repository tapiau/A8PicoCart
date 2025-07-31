//include <config.scad>;

module ridges(cart_length, cart_width, cart_height, ridge_width) {
    for (i = [15: 5: cart_length-5])
        union() {
            translate([i, -ridge_width, 0])
                cube([3, ridge_width, cart_height]);
            translate([i, cart_width, 0])
                cube([3, ridge_width, cart_height]);
        }
}

//if(is_undef(CONFIG)) {
//    include <config.scad>
//    ridges(cart_length, cart_width, cart_height_top, ridge_width);
//}
