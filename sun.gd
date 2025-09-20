class_name Sun
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.play("paper")

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("player_hit sun")
	Events.player_hit.emit()
