$fn=40;

screw_tower_head_height=2.9;
screw_tower_head_height_margin=0.2;
screw_tower_head_radius=5.4/2;
screw_tower_head_radius_margin=0.2;
screw_tower_rod_radius=2.9/2;
screw_tower_rod_radius_margin=0.2;
screw_tower_pcb_radius=3;

module screw_tower_bottom(height) {
    color("green",1.0)
        cylinder(h = height, r1 = screw_tower_head_radius+2, r2 = screw_tower_pcb_radius);
}

module screw_tower_bottom_sub(height) {
    color("red",1.0)
    union() {
        cylinder(
            h = height, 
            r = screw_tower_rod_radius+screw_tower_rod_radius_margin
        );
        cylinder(
            h = screw_tower_head_height+screw_tower_head_height_margin, 
            r = screw_tower_head_radius+screw_tower_head_radius_margin
        );
    }
}

module screw_tower_top(height) {
    color("green",1.0)
        cylinder(h = height, r = screw_tower_pcb_radius);
}

module screw_tower_top_sub(height) {
    slope=1;
    color("red",1.0)
    union() {
        translate([0,0,2])
        cylinder(
            h = height-2, 
            r = screw_tower_rod_radius
        );
        translate([0,0,height-slope])
        cylinder(
            h = slope, 
            r1 = screw_tower_rod_radius,
            r2 = screw_tower_rod_radius+screw_tower_rod_radius_margin*2
        );
    }
}


//if(is_undef(CONFIG)) {
//    include <config.scad>
//    
//    difference() {
//        union(){
//            translate([-6,-5,0])
//                cube([20,10,2]);
//            screw_tower_bottom(cart_height_bottom);
//            translate([10,0,0])
//                screw_tower_top(cart_height_top);
//        }
//        screw_tower_bottom_sub(cart_height_bottom);
//        translate([10,0,0])
//            screw_tower_top_sub(cart_height_top);
//    }
//}
