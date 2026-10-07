// ====================================================================
// MINIMALIST SHELF BRACKET - PARAMETRIC MODEL
// ====================================================================
// This script generates a sleek, minimalist shelf bracket.
// It is designed to be printed flat on the print bed without supports.
// ====================================================================

// --- BRACKET PARAMETERS ---
shelf_len = 210;         // Length of the horizontal arm supporting the shelf (X-axis)
wall_len = 100;          // Length of the vertical arm mounted to the wall (Y-axis)
arm_width = 12;          // Width of the solid outer frame/arms (mm)
arch_thick = 6;          // Thickness of the inner geometric arch (mm)
thickness = 20;          // Total 3D thickness (Z-axis) of the bracket (mm)
$fn = 150;               // High resolution for smooth curves and arcs

// ====================================================================
// STEP 1: BASE 2D SHAPE (Solid frame with a smooth geometric arch)
// ====================================================================
module solid_base() {
    union() {
        // Solid outer frame (ensures a strict 12mm width on both arms)
        polygon([
            [0, 0],
            [shelf_len, 0],
            [shelf_len, -arm_width],
            [arm_width, -arm_width],
            [arm_width, -wall_len],
            [0, -wall_len]
        ]);
        
        // Optimized, long, and smooth supporting arch
        difference() {
            // Rough triangular bounding box for the arch
            polygon([
                [arm_width, -arm_width],
                [155, -arm_width],
                [arm_width, -190] 
            ]);
            // Mathematically calculated cutting circle to create the sleek curve
            translate([150, -195]) circle(r=183);
        }
    }
}

// ====================================================================
// STEP 2: INNER WINDOW (Smooth cutout to form the arch)
// ====================================================================
module inner_window() {
    // The offset(r=2) offset(r=-2) trick rounds sharp internal corners.
    // This acts as a crucial stress relief mechanism to prevent cracking under heavy loads.
    offset(r=2) offset(r=-2)
    difference() {
        // Inner profile protecting the 12mm solid frame
        polygon([
            [arm_width, -arm_width], 
            [105, -arm_width], 
            [arm_width, -120]
        ]);
        
        // The exact same cutting circle from step 1, but expanded by the arch thickness (6mm)
        translate([150, -195]) circle(r=183 + arch_thick);
    }
}

// ====================================================================
// STEP 3: MOUNTING HOLES (Countersunk for a flush flat-head screw fit)
// ====================================================================
module wall_hole(y_pos) {
    // Drilled horizontally along the X-axis (from the inner face towards the wall)
    translate([arm_width + 0.01, y_pos, thickness / 2])
    rotate([0, -90, 0]) {
        cylinder(r=2.5, h=arm_width + 2, $fn=32);              // Clearance hole for the screw shaft (5mm diameter)
        cylinder(r1=5.0, r2=2.5, h=4.5, $fn=32);               // Countersink for the screw head to sit completely flush
    }
}

module shelf_hole(x_pos) {
    // Drilled vertically along the Y-axis (from the inner face towards the shelf)
    translate([x_pos, -arm_width - 0.01, thickness / 2])
    rotate([-90, 0, 0]) {
        cylinder(r=2.5, h=arm_width + 2, $fn=32);              // Clearance hole for the screw shaft (5mm diameter)
        cylinder(r1=5.0, r2=2.5, h=4.5, $fn=32);               // Countersink for the screw head to sit completely flush
    }
}

// ====================================================================
// STEP 4: FINAL 3D MODEL GENERATION
// ====================================================================
difference() {
    // 1. Extrude the 2D profile into a 3D solid
    linear_extrude(height = thickness)
    difference() {
        solid_base();
        inner_window();
    }
    
    // 2. Cut out wall mounting holes (using negative Y coordinates)
    wall_hole(-85); 
    wall_hole(-20); 

    // 3. Cut out shelf mounting holes (using positive X coordinates)
    shelf_hole(170); 
    shelf_hole(195); 
}
