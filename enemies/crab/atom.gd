extends Node2D

@onready var animated_sprite_2d_1: AnimatedSprite2D = $AnimatedSprite2D1
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var animated_sprite_2d_3: AnimatedSprite2D = $AnimatedSprite2D3
@onready var animated_sprite_2d_4: AnimatedSprite2D = $AnimatedSprite2D4

var velocity : Vector2

func _ready() -> void:
	animated_sprite_2d_1.play()
	animated_sprite_2d_2.play()
	animated_sprite_2d_3.play()
	animated_sprite_2d_4.play()

func _physics_process(delta: float) -> void:
	position.x += velocity.x
	position.y += velocity.y
	
	rotate(0.02)
	
	if position.x <= -50:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body is not Player:
		return
	
	var player = body as Player
	if player.iframes:
		return
	
	Events.player_hit.emit()
