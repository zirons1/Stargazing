extends Node2D

@export var shooting_star: PackedScene
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timeout)

func _on_timeout():
	var star = shooting_star.instantiate()

	star.position = Vector2(500, 300)
	star.velocity = Vector2(-1, 0)

	add_child(star)
