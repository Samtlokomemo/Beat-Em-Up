if(layer_instance_get_instance(event_data[? "element_id"]) == id){
    if (event_data[? "event_type"] == "sprite event")
    {
        if(event_data[? "message"] == "atacar")
        {
            var _x1, _x2, _y1, _y2;
            _x1 = (-sprite_xoffset + sprite_get_bbox_left(sprite_index))*face;
            _y1 = -sprite_yoffset + sprite_get_bbox_top(sprite_index);
            _x2 = (-sprite_xoffset + sprite_get_bbox_right(sprite_index))*face;
            _y2 = -sprite_yoffset + sprite_get_bbox_bottom(sprite_index);
            
            myDmg = new Damage(_x1, _y1, _x2, _y2, id);
        }
    } 
}