extends HBoxContainer

@onready var heart_1: AnimatedSprite2D = $Heart1
@onready var heart_2: AnimatedSprite2D = $Heart2
@onready var heart_3: AnimatedSprite2D = $Heart3

@export var heart_anim : String = "default_paper"

var h1 : bool = true
var h2 : bool = true
var h3 : bool = true

func _ready() -> void:
	Events.player_hit.connect(_on_player_hit)
	heart_1.play(heart_anim)
	heart_2.play(heart_anim)
	heart_3.play(heart_anim)

func _on_player_hit() -> void:
	if h3:
		heart_3.play("empty_paper")
		h3 = false
	elif h2:
		heart_2.play("empty_paper")
		h2 = false
	elif h1:
		heart_1.play("empty_paper")
		Events.health_zero.emit()
