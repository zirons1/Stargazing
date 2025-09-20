extends Node2D

@export var solar_flare: PackedScene
@export var laser_scene: PackedScene

@onready var player: CharacterBody2D = $Player
@onready var betelgeuse: Betel = $Betelgeuse

@onready var stats_ui: StatsUI = $StatsUI

const SHOOTING_STAR_SPEED : int = -8

var flip : int = 1

func _ready() -> void:
	Events.health_zero.connect(game_over)
	Events.star_dead.connect(victory)
	stats_ui.set_enemy_max(200)
	betelgeuse.timer.timeout.connect(shoot_star)

func shoot_star() -> void:
	var flare = solar_flare.instantiate()

	var x := randi_range(48, 600)
	var vector := Vector2(1000, x)
	flare.position = vector
	flare.velocity = Vector2(SHOOTING_STAR_SPEED, 0)

	add_child(flare)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		var laser := laser_scene.instantiate()

		flip = -1 if flip == 1 else 1
		laser.position = Vector2(player.position.x + 10, player.position.y + (45 * flip))
		laser.velocity = Vector2(10, 0)

		add_child(laser)

func game_over() -> void:
	print("game over")
	get_tree().paused = true

func victory() -> void:
	print("victory")
	get_tree().paused = true
