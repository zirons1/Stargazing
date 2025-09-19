extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var velocity : Vector2

func _ready() -> void:
	animated_sprite_2d.play()

func _physics_process(delta: float) -> void:
	position.x += velocity.x
	position.y += velocity.y

func _on_body_entered(body: Node) -> void:
	print(body)
	queue_free()

#func _on_VisibilityNotifier2D_screen_exited():
