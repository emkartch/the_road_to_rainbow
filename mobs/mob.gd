extends CharacterBody2D

var speed = randf_range(100, 200)
var health = 3

@onready var player = get_node("/root/Main/Player")

#func _ready():
	#%Slime.play_walk()

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
func mob_take_damage():
	$AnimationPlayer.play("mob_stagger")
	health -= 1
#
	if health == 0:
		queue_free()
