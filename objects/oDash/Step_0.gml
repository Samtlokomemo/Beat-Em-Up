image_alpha  = lerp(image_alpha, 0, .3);
//image_yscale = lerp(image_yscale, 0, .1);
if(image_alpha <= 0){
    instance_destroy(id);
}