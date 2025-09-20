extends Node2D

@export var shooting_star: PackedScene
@export var laser_scene: PackedScene

@onready var player: CharacterBody2D = $Player
@onready var sun: Sun = $Sun

@onready var stats_ui: StatsUI = $StatsUI

const SHOOTING_STAR_SPEED : int = -8

var flip : int = 1

func _ready() -> void:
	Events.health_zero.connect(game_over)
	Events.star_dead.connect(victory)
	stats_ui.set_enemy_max(sun.health)
	sun.timer.timeout.connect(shoot_star)

func shoot_star() -> void:
	var star = shooting_star.instantiate()

	var x := randi_range(48, 600)
	var vector := Vector2(1000, x)
	star.position = vector
	star.velocity = Vector2(SHOOTING_STAR_SPEED, 0)

	add_child(star)
	
	var double : bool = randf() < 0.25
	if double:
		var star2 = shooting_star.instantiate()

		var delta := randi_range(20, 40)
		flip = -1 if flip == 1 else 1
		var vector2 := Vector2(1100, x + (delta  * flip))
		star2.position = vector2
		star2.velocity = Vector2(SHOOTING_STAR_SPEED, 0)

		add_child(star2)
	
		var triple : bool = randf() < 0.25
		if triple:
			var star3 = shooting_star.instantiate()

			var delta2 := randi_range(20, 40)
			flip = -1 if flip == 1 else 1
			var vector3 := Vector2(1200, x + (delta2  * flip))
			star3.position = vector3
			star3.velocity = Vector2(SHOOTING_STAR_SPEED, 0)

			add_child(star3)

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
