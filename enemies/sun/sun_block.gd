extends AnimatedSprite2D

@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2

func _ready() -> void:
	play()
	animated_sprite_2d_2.play()
