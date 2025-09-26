extends Node2D

@export var shooting_star: PackedScene
@export var laser_scene: PackedScene

@export var path_to_betel : String

@onready var player: Player = $Player
@onready var sun: Sun = $Sun
@onready var replay: AnimatedSprite2D = $Replay
@onready var sun_block: AnimatedSprite2D = $SunBlock

@onready var controls_1: Sprite2D = $Controls1
@onready var controls_2: Sprite2D = $Controls2
@onready var controls_3: Sprite2D = $Controls3

var next := 1

@onready var stats_ui: StatsUI = $StatsUI

const SHOOTING_STAR_SPEED : int = -8

var flip : int = 1

var stop := false

func _ready() -> void:
	Events.health_zero.connect(game_over)
	Events.star_dead.connect(victory)
	stats_ui.set_enemy_max(sun.health)
	stats_ui.set_star_health_name(0)
	Events.heal_health()
	stats_ui.player_health.set_health(Events.player_health)
	sun.timer.timeout.connect(shoot_star)
	player.position = Events.player_pos
	
	if Events.show_controls_once:
		Events.show_controls_once = false
		
		stop = true
		player.player_controls_complete.connect(release)
		player.battle_start()
	else:
		release()
	

func release() -> void:
	stop = false
	sun.timer.start()

func shoot_star() -> void:
	if stop:
		return
	
	var star = shooting_star.instantiate()

	var x := randi_range(48, 600)
	var vector := Vector2(1000, x)
	star.position = vector
	star.velocity = Vector2(SHOOTING_STAR_SPEED, 0)

	add_child(star)
	
	var percent_health := stats_ui.enemy_health.value / sun.health
	
	var double : bool
	if percent_health > .70:
		double = randf() < 0.25
	elif percent_health > .50:
		double = randf() < 0.65
	else: 
		double = randf() < 0.85
	
	if double:
		var star2 = shooting_star.instantiate()

		var delta := randi_range(20, 40)
		flip = -1 if flip == 1 else 1
		var vector2 := Vector2(1100, x + (delta  * flip))
		star2.position = vector2
		star2.velocity = Vector2(SHOOTING_STAR_SPEED, 0)

		add_child(star2)
	
	var triple : bool
	if percent_health > .70:
		triple = randf() < 0.25
	elif percent_health > .50:
		triple = randf() < 0.35
	else: 
		triple = randf() < 0.65
	
	if triple:
		if triple:
			var star3 = shooting_star.instantiate()

			var delta2 := randi_range(20, 40)
			flip = -1 if flip == 1 else 1
			var vector3 := Vector2(1200, x + (delta2  * flip))
			star3.position = vector3
			star3.velocity = Vector2(SHOOTING_STAR_SPEED, 0)

			add_child(star3)

func _input(event: InputEvent) -> void:
	if stop:
		return
	
	if event.is_action_pressed("space"):
		var laser := laser_scene.instantiate()

		flip = -1 if flip == 1 else 1
		laser.position = Vector2(player.position.x + 10, player.position.y + (45 * flip))
		laser.velocity = Vector2(10, 0)

		add_child(laser)

func game_over() -> void:
	print("game over")
	stop = true
	player.disabled = true
	replay.show()
	Events.reset_player_health()
	Events.reset_player_pos()
	
	for attack in get_tree().get_nodes_in_group("attacks"):
		attack.queue_free()

func victory() -> void:
	print("victory")
	stats_ui.hide_curr()
	stop = true
	player.disabled = true
	Events.player_pos = player.position
	
	for attack in get_tree().get_nodes_in_group("attacks"):
		attack.queue_free()
	
	sun.move()
	sun.end_move.connect(transition_to_betel)

func transition_to_betel() -> void:
	get_tree().change_scene_to_file(path_to_betel)
