extends Node2D

@export var laser_scene: PackedScene
@export var path_to_sag : String

@onready var player: CharacterBody2D = $Player
@onready var sag_a: Sag = $SagA

@onready var replay: AnimatedSprite2D = $Replay

@onready var stats_ui: StatsUI = $StatsUI

@onready var atom_timer: Timer = $AtomTimer

const SPINNER_SPEED : int = -3

var flip : int = 1

var stop := false

func _ready() -> void:
	Events.health_zero.connect(game_over)
	Events.star_dead.connect(victory)
	stats_ui.set_enemy_max(sag_a.health)
	stats_ui.set_star_health_name(3)
	stats_ui.player_health.set_health(Events.player_health)
	player.position = Events.player_pos

#func pulsar(pulse_pos : int) -> void:
	#if stop:
		#return
	#
	#var pulse = pulse_scene.instantiate()
	#var vector := Vector2(1000, pulse_pos)
	#pulse.position = vector
	#var do_beam := randf() > 0.55
	#pulse.do_beam = do_beam
	#add_child(pulse)
	#
	#if not do_beam:
		#spinner_out(pulse.position)
	#
	#get_tree().create_timer(randf_range(2.5, 4.5)).timeout.connect(func(): pulsar(pulse_pos))
	#var percent_enemy_health = stats_ui.enemy_health.value / crab_pulsar.health
	#pulse_position.y += [-50, 50].pick_random()
	#
	#if percent_enemy_health  > 0.7:
		#var spinner := spinner_scene.instantiate()
		#spinner.position = pulse_position
		#spinner.velocity = Vector2(SPINNER_SPEED, 0)
		#get_tree().create_timer(1.0).timeout.connect(
		#func():
			#if not stop:
				#add_child(spinner)
		#)
	#else:
		#var spinner := spinner_scene.instantiate()
		#spinner.position = pulse_position
		#spinner.velocity = Vector2(SPINNER_SPEED, 0)
		#get_tree().create_timer(0.2).timeout.connect(
		#func():
			#if not stop:
				#add_child(spinner)
		#)
		#var spinner2 := spinner_scene.instantiate()
		#spinner2.position = pulse_position
		#spinner2.velocity = Vector2(SPINNER_SPEED, 0)
		#get_tree().create_timer(1.3).timeout.connect(
		#func():
			#if not stop:
				#add_child(spinner2)
		#)

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

	sag_a.move()
	sag_a.end_move.connect(finale)

# TODO
func finale() -> void:
	#get_tree().change_scene_to_file(path_to_sag)
	replay.show()
