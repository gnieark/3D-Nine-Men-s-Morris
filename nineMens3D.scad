/*
* 3D nine mens'moris
* By Gnieark https://blog-du-grouik.tinad.fr
*
* github: https://github.com/gnieark/3D-Nine-Men-s-Morris
*
* License GNU-GPL V3
*/


checkerRadius=9;
checkerHoleRadius=7;

waysDst=25;
nbeCubes=3;

for(zt=[0 : nbeCubes]){
    checkerCube(waysDst*zt);
    checkerCubeLiens(waysDst*zt);
}
for(zt=[1 : nbeCubes -1]){
    for (angle=[0,90,180,270]){
      rotate([0,0,angle])  
            translate([zt * waysDst,-checkerRadius/2,0])
                cube([waysDst,checkerRadius,2.99]);
    }
   translate([0,0,zt* waysDst]) ZLink(); 
    translate([0,0, (- zt - 1)* waysDst]) ZLink(); 
     
}
module checkerCube(ecartement =25){
        for(z=[-1 * ecartement,0, ecartement]){
           for(y=[-1 * ecartement,0, ecartement]){
               for(x=[-1 * ecartement,0, ecartement]){
                   if ((x==0) && (y==0) && (z==0)){                    
                   }else{
                      translate([x,y,z]) checkerbase(); 
                   }
               }
           } 
        }
}

module checkerCubeLiens(ecartement=25){
    hgCube= (ecartement *2) + checkerRadius;
    liCube= (ecartement *2) - checkerRadius;
    for(z=[-1 * ecartement,0, ecartement]){
        translate([0,0,z+1.5])
            difference(){
                cube([hgCube,hgCube,2.99], center=true);
                cube([liCube,liCube,3], center=true);
            }
    }
    for(z=[-1 * ecartement, ecartement]){
        translate([-ecartement,-checkerRadius/2,z]) cube([2*ecartement,checkerRadius,2.99]);
        
         rotate([0,0,90]) translate([-ecartement,-checkerRadius/2,z]) cube([2*ecartement,checkerRadius,2.99]);
        
    }
    translate([ecartement,0,-ecartement]) 
        rotate([0,0,180])
            ZLink(ecartement*2 );
    translate([-ecartement,0,-ecartement])
        ZLink(ecartement*2 );
    
        translate([0,ecartement,-ecartement]) 
            rotate([0,0,270])
                ZLink(ecartement*2 );
    translate([0,-ecartement,-ecartement])
        rotate([0,0,90])
            ZLink(ecartement*2 );  
}

module ZLink(hight=25){
    difference(){
        cylinder(r=checkerRadius, h=hight, $fn=100);
        union(){
            translate([0,0,-0.01]) cylinder(r=checkerHoleRadius, h=hight, $fn=100);
           translate ([-checkerRadius - 0.1,-checkerRadius - 0.1,-0.01])
            cube([checkerRadius+0.2,2* checkerRadius+ 2,hight +1]);
        }
    }
}
module checkerbase(){
    difference(){
        cylinder(r=checkerRadius, h=5, $fn=100);
        translate([0,0,3]) cylinder(r=checkerHoleRadius, h=5, $fn=100);
    }
}