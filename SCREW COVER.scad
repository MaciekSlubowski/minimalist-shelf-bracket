// ====================================================================
// PARAMETRIC SCREW COVER / CAP (OPTIMIZED FOR 3D PRINTING)
// ====================================================================
// This script generates a customizable screw cap designed to fit directly 
// into the screw head (e.g., PZ2/PH2) or a standard hole.
// It is designed to be printed flat on the build plate without supports.
// ====================================================================
$fn = 64;

// --- MAIN CAP DIMENSIONS (VISIBLE PART) ---
cap_diameter          = 10.5; // Outer diameter of the cap (mm) - match to your screw head or countersink
cap_thickness         = 1.4;  // Thickness of the visible cap cover (mm)
edge_chamfer          = 0.6;  // Chamfer/radius on the top outer edge (mm) for a smooth look

// --- MOUNTING STEM TYPE SELECTION ---
// "cross" - 4-blade wedge pressed directly into a PZ/PH screw drive
// "plug"  - Slightly tapered solid cylinder pressed into a stripped or round hole
mount_type            = "cross"; // ["cross", "plug"]

// --- CROSS MOUNT PARAMETERS (Default: PZ2) ---
cross_length          = 2.2;  // Insertion depth into the screw drive (mm)
cross_span_base       = 4.4;  // Total span of the blades at the base (mm)
cross_span_tip        = 2.8;  // Total span of the blades at the tip (mm)
cross_blade_thickness = 1.2;  // Thickness of a single cross blade (mm)

// --- PLUG MOUNT PARAMETERS (Alternative for thick nozzles / stripped screws) ---
plug_diameter_base    = 4.6;  // Diameter at the base/cap connection (mm)
plug_diameter_tip     = 3.8;  // Diameter at the insertion tip (mm)
plug_length           = 2.2;  // Total length of the plug (mm)

// ====================================================================
// MODEL GEOMETRY
// ====================================================================

// Generates the flat, visible part of the cap with a chamfered top edge
module cap_face() {
    hull() {
        cylinder(r = (cap_diameter / 2) - edge_chamfer, h = cap_thickness);
        translate([0, 0, edge_chamfer])
            cylinder(r = cap_diameter / 2, h = cap_thickness - edge_chamfer);
    }
}

// Generates a single tapered blade for the cross mount
module cross_blade(length, span_bottom, span_top, thick_bottom, thick_top) {
    hull() {
        cube([span_bottom, thick_bottom, 0.01], center = true);
        translate([0, 0, length])
            cube([span_top, thick_top, 0.01], center = true);
    }
}

// Combines two perpendicular blades to form the Phillips/Pozidriv cross
module cross_stem() {
    translate([0, 0, cap_thickness]) {
        cross_blade(cross_length, cross_span_base, cross_span_tip, cross_blade_thickness, cross_blade_thickness * 0.8);
        cross_blade(cross_length, cross_blade_thickness, cross_blade_thickness * 0.8, cross_span_base, cross_span_tip);
    }
}

// Generates the alternative tapered solid plug
module plug_stem() {
    translate([0, 0, cap_thickness])
        cylinder(d1 = plug_diameter_base, d2 = plug_diameter_tip, h = plug_length);
}

// ====================================================================
// FINAL ASSEMBLY
// ====================================================================
union() {
    // Render the main visible cap
    cap_face();
    
    // Render the chosen mounting mechanism
    if (mount_type == "cross") {
        cross_stem();
    } else if (mount_type == "plug") {
        plug_stem();
    }
}