if(life < 100){
    life += 10
    instance_destroy(other)
    if (life > 100){
        life = 100
    }
}