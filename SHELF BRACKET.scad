// ==========================================
// PARAMETRY WSPORNIKA
// ==========================================
shelf_len = 210;         // Długość ramienia pod półkę (oś X)
wall_len = 100;          // Długość ramienia przy ścianie (oś Y)
arm_width = 12;          // Grubość płaskiej ramy nośnej (12 mm)
arch_thick = 6;          // GRUBOŚĆ ŁUKU - 6 mm (50% cieńszy od ramy)
thickness = 20;          // Grubość całkowita 3D
$fn = 150;               // Bardzo wysoka rozdzielczość krzywizn

// ==========================================
// KROK 1: Bryła bazowa 2D (Płynny, aerodynamiczny łuk)
// ==========================================
module solid_base() {
    union() {
        // Lita rama brzegowa (gwarantuje 12 mm na ramionach)
        polygon([
            [0, 0],
            [shelf_len, 0],
            [shelf_len, -arm_width],
            [arm_width, -arm_width],
            [arm_width, -wall_len],
            [0, -wall_len]
        ]);
        
        // Zoptymalizowany, długi i płynny łuk
        difference() {
            polygon([
                [arm_width, -arm_width],
                [155, -arm_width],
                [arm_width, -190] 
            ]);
            // Matematycznie wyliczony okrąg tnący
            translate([150, -195]) circle(r=183);
        }
    }
}

// ==========================================
// KROK 2: Wewnętrzne okno (Płynna łezka)
// ==========================================
module single_window() {
    offset(r=2) offset(r=-2)
    difference() {
        // Wewnętrzny zarys okna chroniący 12 mm ramy
        polygon([
            [arm_width, -arm_width], 
            [105, -arm_width], 
            [arm_width, -120]
        ]);
        
        // Ten sam okrąg tnący powiększony o grubość łuku (6 mm)
        translate([150, -195]) circle(r=183 + arch_thick);
    }
}

// ==========================================
// KROK 3: Prawidłowe otwory montażowe (Poziome)
// ==========================================
module wall_hole(y_pos) {
    // Wiercone w osi X od wewnętrznego lica (X = 12) w stronę ściany
    translate([arm_width + 0.01, y_pos, thickness / 2])
    rotate([0, -90, 0]) {
        cylinder(r=2.5, h=arm_width + 2, $fn=32);              // Przelot na śrubę
        cylinder(r1=5.0, r2=2.5, h=4.5, $fn=32);                 // Faza stożkowa zlicowana z ramą
    }
}

module shelf_hole(x_pos) {
    // Wiercone w osi Y od wewnętrznego lica (Y = -12) w stronę półki
    translate([x_pos, -arm_width - 0.01, thickness / 2])
    rotate([-90, 0, 0]) {
        cylinder(r=2.5, h=arm_width + 2, $fn=32);              // Przelot na śrubę
        cylinder(r1=5.0, r2=2.5, h=4.5, $fn=32);                 // Faza stożkowa zlicowana z ramą
    }
}

// ==========================================
// KROK 4: GENEROWANIE GŁÓWNEGO MODELU 3D
// ==========================================
difference() {
    // 1. Profil 2D wyciągnięty na grubość
    linear_extrude(height = thickness)
    difference() {
        solid_base();
        single_window();
    }
    
    // 2. Otwór do ściany 
    wall_hole(-85); 
    wall_hole(-20); 

    
    // 3. Otwory pod półkę (drugi otwór przesunięty na X = 130 zgodnie z zaznaczeniem)
    shelf_hole(170); 
    shelf_hole(195); 
}