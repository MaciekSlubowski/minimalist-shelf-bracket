Minimalist Shelf Bracket

A sleek, fully parametric 3D-printable wall mount for shelves. Written in OpenSCAD, this minimalist bracket features a smooth geometric arch, clean lines, and a topology-inspired design optimized for flat, support-free FDM printing. It combines modern aesthetics with high structural integrity.<img width="1087" height="601" alt="4" src="https://github.com/user-attachments/assets/f99d16ed-cd32-420d-ba2f-5917572f9df1" />
## 📷 Gallery

<p align="center">
  <img src="https://github.com/user-attachments/assets/670f02c0-c0a2-47e7-83ff-c3b8a3493a11" width="48%" alt="Assembled Shelves System">
  <img src="https://github.com/user-attachments/assets/c17f9dc3-8ee9-48c3-aba7-cc42ce8054db" width="48%" alt="Mounted Bracket Close-up">
</p>
<p align="center">
  <i>Left: The brackets mounted on a solid wall, seamlessly supporting wooden shelf boards. Right: Close-up of the flush fit and sleek arch supporting the shelf.</i>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/586f231e-c2e9-4a24-aed1-847d345d2f77" width="48%" alt="Printed Bracket on Table">
  <img src="https://github.com/user-attachments/assets/dc88c26e-4d74-464b-8092-6cb94d07777c" width="48%" alt="Cura Slicer View">
</p>
<p align="center">
  <i>Left: The printed bracket showing clean layer lines and perfectly formed countersunk holes. Right: Slicer visualization demonstrating the flat, support-free print orientation.</i>
</p>



📏 Default Dimensions

Based on the default parameters in the OpenSCAD file, the generated bracket has the following specifications:

Shelf Arm (X-axis): 210 mm

Wall Arm (Y-axis): 100 mm

Frame Width: 12 mm

Total Thickness: 20 mm

Mounting Holes: Countersunk, designed for standard flat-head screws to sit completely flush with the surface.

✨ Features

Fully Parametric: Easily adjust arm lengths, frame width, arch thickness, and overall depth directly in the OpenSCAD file to fit any shelf size.

Support-Free Printing: Carefully designed to be printed completely flat on the build plate. Requires zero support structures, saving material and post-processing time.

Sleek & Minimalist: Relies on simple, unobtrusive geometry that blends perfectly into modern, Scandinavian, or industrial interiors.

## ⚙️ Key OpenSCAD Variables

The bracket is fully customizable. You can easily adapt the geometry to your specific needs by modifying the following variables at the top of the `.scad` file:

*   **`shelf_len`** (Default: `210`): The length of the horizontal arm supporting the shelf (along the X-axis).
*   **`wall_len`** (Default: `100`): The length of the vertical arm mounted to the wall (along the Y-axis).
*   **`arm_width`** (Default: `12`): The width of the solid outer frame. This determines the main structural rigidity of the bracket.
*   **`arch_thick`** (Default: `6`): The thickness of the inner geometric arch. Kept thinner than the main frame to maintain a sleek, visually lightweight aesthetic.
*   **`thickness`** (Default: `20`): The total 3D depth (Z-axis) of the printed bracket.
*   **`$fn`** (Default: `150`): The resolution parameter. Set high to ensure the geometric curves and countersunk holes render perfectly smooth.

## 🔧 Pro-Tip: Fixing Misaligned Drill Holes

Did your drill bit slip on the masonry, leaving the holes in your wall slightly too high or too low? Don't drill new holes and ruin your wall! You can easily shift the mounting holes directly on the 3D model to perfectly match the mistake on your wall. 

Just scroll down to **STEP 4: FINAL 3D MODEL GENERATION** in the OpenSCAD code and adjust the coordinates passed to the hole functions:
*   `wall_hole(-85);` ➔ Change the `-85` (Y-axis) to move the hole up or down along the wall arm.
*   `shelf_hole(170);` ➔ Change the `170` (X-axis) to shift the shelf mounting hole left or right.

   
🖨️ Recommended Print Settings

To ensure the bracket can safely support loads (like thick wooden boards and books) without snapping, follow these guidelines

Material: PETG or PETG-CF (Carbon Fiber) works best for superior layer adhesion, impact resistance, and slight flexibility under load. 

Layer Height: 0.20 mm - 0.24 mm. While a 0.8 mm nozzle can print thicker layers, keeping it around 0.24 mm ensures the curved organic arch remains smooth and aesthetically pleasing.

Walls/Perimeters: 4-5 walls. This is CRITICAL. The structural strength of a bracket comes primarily from its thick outer perimeters, not the infill.

Top/Bottom Thickness: ~1.4 mm (approx. 5-8 layers depending on your layer height) to ensure solid mounting points.

Infill: 20% - 25% Gyroid. The 3D gyroid pattern distributes stress evenly across all axes, perfectly complimenting the topology-optimized arch.

⚠️ Note on Hardware & Hole Tolerances

FDM plastics often shrink, and thick 0.8 mm extrusions can slightly squish into holes.

Hole Horizontal Expansion: In your slicer (e.g., Cura), set this to 0.4 mm. This compensates for the shrinkage and ensures your screws will slide in smoothly without splitting the printed layers when tightened.

Mounting Hardware: For solid walls (like silicate blocks or concrete), use high-quality 8x40 expansion anchors (e.g., Fischer SX Plus) with matching 4-5 mm flat-head screws. Do not overtighten—let the flush countersink distribute the pressure.

This project is open-source and provided strictly for personal, educational, and non-commercial purposes. You are free to explore, modify, and learn from the codebase. If you wish to use this project for commercial purposes, please contact me. Maciej Ślubowski
