extends Node

func spawn_mob():
	%PathFollow2D.progress_ratio = randf()
	var new_mob = preload("res://mobs/mob.tscn").instantiate()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
func _ready() -> void:
	spawn_mob()
