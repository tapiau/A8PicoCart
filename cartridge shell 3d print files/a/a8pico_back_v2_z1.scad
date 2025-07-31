include <a8pico_config.scad>;


$fn=40;

module screwTowerSub(height = 40) {
    // $fs=0.1;
    $fn=40;
    
    color("red",1.0)
    union() {
        cylinder(h = support_height - 1.1, r1 = screw_rod_radius+screw_rod_radius_margin, r2 = screw_rod_radius+screw_rod_radius_margin);
        cylinder(h = screw_head_height+screw_head_height_margin, r = screw_head_radius+screw_head_radius_margin);
    }
}

module screwTower(support_height) {
    color("green",1.0)
        cylinder(h = support_height - 1.2, r1 = screw_head_radius+2, r2 = 3);
}

module ridges() {
    for (i = [15: 5: cart_length-5])
        union() {
            translate([i, -ridge_width, 0])
                cube([3, ridge_width, cart_height-rim_height]);
            translate([i, cart_width, 0])
                cube([3, ridge_width, cart_height-rim_height]);
        }
}

module cart_back() {
    difference() {
        union() {
            difference() {
                // main shell
                union() {
                    cube([cart_length, cart_width, cart_height-rim_height]);
                    // rim
                    translate([0, sides_thickness/2, cart_height-rim_height])
                        cube([cart_length-sides_thickness/2, sides_thickness/2, rim_height]);
                    translate([0, cart_width-sides_thickness, cart_height-rim_height])
                        cube([cart_length-sides_thickness/2, sides_thickness/2, rim_height]);
                    translate([cart_length-sides_thickness, sides_thickness/2, cart_height-rim_height])
                        cube([sides_thickness/2, cart_width-sides_thickness, rim_height]);
                }
                // make hollow
                translate([0, sides_thickness, front_thickness])
                    cube([cart_length-sides_thickness,
                        cart_width-sides_thickness*2,
                        cart_height-front_thickness]);
            }    
            // end
            cube([sides_thickness, cart_width, 4]);
            // pcb supports
            difference() {
                translate([17, sides_thickness, 0])
                    cube([support_thickness, cart_width-sides_thickness*2, cart_height]);
                translate([17, (cart_width-55)/2, support_height])
                    cube([support_thickness, 55, cart_height-support_height]);
            }
            translate([60, 0, 0])
                cube([support_thickness, 7, support_height]);
            translate([60, cart_width-7, 0])
                cube([support_thickness, 7, support_height]);
            // screw holes
            translate([31, (cart_width-screw_sep)/2, 0])
                screwTower(support_height);
            translate([31, cart_width-(cart_width-screw_sep)/2, 0])
                screwTower(support_height);
            // ridges
            ridges();
        }

        translate([31, (cart_width-screw_sep)/2, 0])
            screwTowerSub(support_height);
        translate([31, cart_width-(cart_width-screw_sep)/2, 0])
            screwTowerSub(support_height);

         // cutout USB slot
        translate([0, (cart_width-16)/2+0.5, front_thickness])    // pico is 0.5 mm off center
            cube([40, 16, cart_height]);
    }
}

intersection() {
    cart_back();

//    color("blue")
//        translate([20,5,0])
//            cube([20,10,20]);
}