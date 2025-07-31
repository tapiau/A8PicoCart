/* A8PicoCart shell
   (c) R.Edwards 2023
*/

ridge_width = 0.5;
cart_length=80;
cart_width=65 - (ridge_width*2);
cart_height=11.5;
screw_sep = 44;
front_thickness = 1.6;
sides_thickness = 1.6 - 0.05;
support_thickness = 1.2 - 0.05;
support_height = 10.5;
rim_height=1;
screw_head_h=2;

screw_head_height=2.9;
screw_head_radius=5.4/2;
screw_rod_radius=2.9/2;

module screwPlaceholder(height = 40) {
    // $fs=0.1;
    $fn=40;
    
    color("red",1.0)
    union() {
        cylinder(h = screw_head_height, r = screw_head_radius);
        cylinder(h = height, r = screw_rod_radius);
    }
}

module screwTower(support_height) {
    difference() {
        cylinder(h = support_height - 1.2, r1 = 4, r2 = 3,  $fs = 1);
        cylinder(h = support_height - 1.1, r1 = 1.8, r2 = 1.8,  $fs = 1);
    }
}

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
        for (i = [15: 5: cart_length-5])
            union() {
                translate([i, -ridge_width, 0])
                    cube([3, ridge_width, cart_height-rim_height]);
                translate([i, cart_width, 0])
                    cube([3, ridge_width, cart_height-rim_height]);
            }
    }
    // screw head
    translate([31, (cart_width-screw_sep)/2, -0.1])
        cylinder(h = 2, r1 = 3.5, r2 = 3.5,  $fs = 1);
    translate([31, (cart_width-screw_sep)/2, screw_head_h + 0.1])
        cylinder(h = front_thickness-0.6, r1 = 3.5, r2 = 2.8,  $fs = 1);

    translate([31, cart_width-(cart_width-screw_sep)/2, -0.1])
        cylinder(h = 2, r1 = 3.5, r2 = 3.5,  $fs = 1);
    translate([31, cart_width-(cart_width-screw_sep)/2, screw_head_h + 0.1]) {
        cylinder(h = front_thickness-0.6, r1 = 3.5, r2 = 2.8,  $fs = 1);
    }
     // cutout USB slot
    translate([0, (cart_width-16)/2+0.5, front_thickness])    // pico is 0.5 mm off center
        cube([40, 16, cart_height]);
}
