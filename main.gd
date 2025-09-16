extends Node

var main_game_running = false
var boss_level = false
var level_count = 1

@onready var hud = get_node("/root/Main/HUD")
@onready var player = get_node("/root/Main/Player")
@onready var healthBar = get_node("/root/Main/Player/HealthBar")

func spawn_mob(scale, health):
	%PathFollow2D.progress_ratio = randf()
	var new_mob = preload("res://mobs/mob.tscn").instantiate()
	new_mob.global_position = %PathFollow2D.global_position
	new_mob.global_scale = scale
	new_mob.health = health
	add_child(new_mob)

func _ready():
	pass
	
func _process(delta: float) -> void:
	var mob_group = 	get_tree().get_nodes_in_group("mobs").is_empty()
	if main_game_running and mob_group and boss_level:
		if level_count == 1:
			hud.show_message("Level 2")
			main_game_running = false
			boss_level = false
			level_count += 1
			level_two()
		elif level_count == 2:
			hud.show_message("Level 3")
			main_game_running = false
			boss_level = false
			level_count += 1
			level_three()
		elif level_count == 3:
			await get_tree().create_timer(0.5).timeout
			main_game_running = false
			boss_level = false
			$HUD.show_win()
			$Player.hide()
	elif main_game_running and mob_group:
		if level_count == 1:
			spawn_mob(Vector2(2,2),6)
			boss_level = true
		elif level_count == 2:
			spawn_mob(Vector2(3,3),8)
			boss_level = true
		elif level_count == 3:
			spawn_mob(Vector2(4,4),10)
			boss_level = true

func _on_player_health_depleted():
	#$ScoreTimer.stop()
	#$MobTimer.stop()
	get_tree().call_group("mobs", "queue_free")
	main_game_running = false
	$HUD.show_game_over()
	#get_tree().paused = true

func new_game() -> void:
	$Player.start($StartPosition.position)
	for i in range(4):
		spawn_mob(Vector2(1,1),3)
		await get_tree().create_timer(1).timeout
	main_game_running = true

func level_two() -> void:
	if player.health < 100.0:
		if player.health <= 75.0:
			player.health += 25.0
		else:
			player.health = 100.0
	healthBar.value = player.health
	for i in range(6):
		spawn_mob(Vector2(1,1),4)
		await get_tree().create_timer(1).timeout
	main_game_running = true
	
func level_three() -> void:
	if player.health < 100.0:
		if player.health <= 75.0:
			player.health += 25.0
		else:
			player.health = 100.0
	healthBar.value = player.health
	for i in range(8):
		spawn_mob(Vector2(1,1),5)
		await get_tree().create_timer(1).timeout
	main_game_running = true
