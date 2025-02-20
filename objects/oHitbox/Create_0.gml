destroy = time_source_create(time_source_global, .1, time_source_units_seconds, instance_destroy, [id]);
time_source_start(destroy);