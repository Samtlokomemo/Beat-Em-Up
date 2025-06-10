if (id == other.creator) {
    exit; // Sai do evento, não faz nada
}else{
    knockbackDirection = point_direction(other.x, other.y, x, y);
    state = DamageState;
    instance_destroy(other);
    life -= damage;
}
