class_name SolarFlare
extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var velocity : Vector2

func _ready() -> void:
	animated_sprite_2d.play("paper")

func _physics_process(delta: float) -> void:
	position.x += velocity.x
	position.y += velocity.y
	
	if position.x <= -50:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body is not Player:
		return
	
	var player = body as Player
	if player.iframes:
		return
	
	Events.player_hit.emit()
	queue_free()
