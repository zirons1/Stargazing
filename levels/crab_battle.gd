extends Node2D

@export var pulse_scene: PackedScene
@export var laser_scene: PackedScene

@onready var player: CharacterBody2D = $Player
@onready var crab_pulsar: Crab = $CrabPulsar

@onready var replay: AnimatedSprite2D = $Replay

@onready var stats_ui: StatsUI = $StatsUI

@onready var timer: Timer = $Timer

const SHOOTING_STAR_SPEED : int = -8

var flip : int = 1

var pulse_pos = [150, 350, 550]

var stop := false

func _ready() -> void:
	Events.health_zero.connect(game_over)
	Events.star_dead.connect(victory)
	stats_ui.set_enemy_max(crab_pulsar.health)
	stats_ui.set_health_sprite(2)
	timer.timeout.connect(pulsar)

func pulsar() -> void:
	if stop:
		return
	
	var pulse = pulse_scene.instantiate()

	var x : int = pulse_pos.pick_random()
	var vector := Vector2(1000, x)
	pulse.position = vector

	add_child(pulse)

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
	
	for attack in get_tree().get_nodes_in_group("attacks"):
		attack.queue_free()

func victory() -> void:
	print("victory")
	stop = true
	player.disabled = true
	replay.show()
	
	for attack in get_tree().get_nodes_in_group("attacks"):
		attack.queue_free()
