extends Area2D

signal on_body_entered

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play()


func _on_body_entered(body: Node) -> void:
	if body is not Player:
		return
	
	var player = body as Player
	if player.iframes:
		return
	
	on_body_entered.emit(body)
