module logo_sv2025(cart_width, cart_length) {
    translate([cart_length*2/3-10,cart_width/2,0])
    rotate([0,0,90])
    scale([1,-1,1])
    resize([cart_width*0.9,0,0.4], auto=true)
    linear_extrude(1)
    import(file="8bitlogo_bw_reduced.svg", center = true);
}


if(is_undef(CONFIG)) {
    include <../config.scad>
    logo_sv2025(cart_width,cart_length);
}
