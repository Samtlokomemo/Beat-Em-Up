function Damage(_x1, _y1, _x2, _y2) constructor {
    
    myX = other.x;
    myY = other.y;
    myZ = other.z;
    
    x1 = _x1;
    x2 = _x2;
    y1 = _y1;
    y2 = _y2;
    
    static draw_area = function(){
        draw_rectangle(x1 + myX, y1 + myY + myZ, x2 + myX, y2 + myY + myZ, true);
    }
    
    static update_area = function(){
        myX = other.x;
        myY = other.y;
        myZ = other.z;
    }
}