extends Node2D

@export var solar_flare: PackedScene
@export var twinkle: PackedScene
@export var laser_scene: PackedScene
@export var path_to_crab : String

@onready var player: CharacterBody2D = $Player
@onready var betelgeuse: Betel = $Betelgeuse
@onready var replay: AnimatedSprite2D = $Replay

@onready var solar_flare_timer: Timer = $SolarFlareTimer

@onready var stats_ui: StatsUI = $StatsUI

var stop := false

const SOLAR_FLARE_SPEED : int = -12
const TWINKLE_SPEED : int = -18

var solar_attack := true

var flip : int = 1

var flares := []

var pos_arr := [100, 250, 400, 550]

var mist_pos := [150, 350, 550]

func _ready() -> void:
	Events.health_zero.connect(game_over)
	Events.star_dead.connect(victory)
	stats_ui.set_enemy_max(betelgeuse.health)
	stats_ui.set_star_health_name(1)
	stats_ui.player_health.set_health(Events.player_health)
	solar_flare_timer.timeout.connect(shoot_star)
	player.position = Events.player_pos

func shoot_star() -> void:
	if stop:
		return
	
	if flares.is_empty():
		pos_arr.shuffle()
		for i in range(3):
			var flare = solar_flare.instantiate()
			var vector := Vector2(1000, pos_arr[i])
			flare.position = vector
			flare.velocity = Vector2(SOLAR_FLARE_SPEED, 0)
			
			flares.append(flare)

	var curr_flare : SolarFlare = flares.pop_front()
	for i in range(4):
		var twinkle : Twinkle = twinkle.instantiate()
		var vector := Vector2(1000, curr_flare.position.y)
		twinkle.position = vector
		twinkle.velocity = Vector2(TWINKLE_SPEED + randi_range(-5, 5), randf_range(-7, 7))
		
		add_child(twinkle)
		
		var phase := randi_range(1, 3)
		twinkle.start(phase)
	add_child(curr_flare)

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
	stop = true
	player.disabled = true
	Events.player_pos = player.position
	
	for attack in get_tree().get_nodes_in_group("attacks"):
		attack.queue_free()

	betelgeuse.move()
	betelgeuse.end_move.connect(transition_to_crab)

func transition_to_crab() -> void:
	get_tree().change_scene_to_file(path_to_crab)
