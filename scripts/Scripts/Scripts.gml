function Damage(_x1, _y1, _x2, _y2, _parent = noone) constructor {
    
    myX = other.x;
    myY = other.y;
    myZ = other.z;
    face = other.face;
    
    x1 = _x1;
    x2 = _x2;
    y1 = _y1;
    y2 = _y2;
    parent = _parent;
    
    static draw_area = function(){
        draw_rectangle(x1 + myX, y1 + myY + myZ, x2 + myX, y2 + myY + myZ, true);
    }
    
    static update_area = function(){
        myX = other.x;
        myY = other.y;
        myZ = other.z;
    }
    
    static collision_check = function(){
        var _x1, _y1, _x2, _y2;
        _x1 = x1 + myX;
        _y1 = y1 * 2 + myY + myZ;
        _x2 = x2 * 2 + myX;
        _y2 = y2 * -2 + myY + myZ;
        
        //draw_rectangle(_x1, _y1, _x2, _y2, true);
        var _list = ds_list_create();
        var _others = collision_rectangle_list(_x1, _y1, _x2, _y2, oEntidade, 1, 1, _list, 1); 
        var _size = ds_list_size(_list);
        if(_size > 0){
            for (var i = 0; i < _size; i++) {
                var _other = _list[| i];
                if(_other.object_index != parent.object_index){
                    var _hurt = _other.hurtBox;
                    var _dmg = rectangle_in_rectangle(x1 + myX, y1 + myY + myZ, x2 + myX, y2 + myY + myZ,
                    _hurt.x1 + _hurt.myX, _hurt.y1 + _hurt.myY + _hurt.myZ, _hurt.x2 + _hurt.myX, _hurt.y2 + _hurt.myY + _hurt.myZ)
                    
                    if(_dmg){
                        if (_other.invulnerableTime <= 0) { 
                            _other.life-=5;
                            _other.state = _other.DamageState;
                        }
                        
                    }
                }
            }
        }
        ds_list_destroy(_list);
    }
}

function HurtBox(_x1, _y1, _x2, _y2, _parent = noone) : Damage(_x1, _y1, _x2, _y2) constructor {
    
}