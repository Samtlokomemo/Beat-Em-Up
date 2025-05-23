z += zspd;
if(z < 0){
    zspd += grav;
} else {
    zspd = 0;
    z = 0;
}