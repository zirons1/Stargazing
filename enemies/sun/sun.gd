class_name Sun
extends CharacterBody2D

signal end_move

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var collision_shape_2d2: CollisionShape2D = $Area2D/CollisionShape2D
@onready var sun_block: AnimatedSprite2D = $SunBlock

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var timer: Timer = $Timer

@export var health : int

var disabled := false

func _ready() -> void:
	animated_sprite_2d.play("paper")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if disabled:
		return
	
	#print("player_hit sun")
	Events.player_hit.emit()

func move() -> void:
	disabled = true
	sun_block.show()
	
	var tween := create_tween()
	tween.tween_property(self, "position", Vector2.LEFT * 2500, 2.0)
	tween.finished.connect(func(): end_move.emit())
