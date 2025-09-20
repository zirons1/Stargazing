class_name PlayerHealth
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

func set_health(health : int) -> void:
	if health > 3:
		health = 3
	elif health <= 0:
		Events.health_zero.emit()
	
	if health == 3:
		h3 = true
		h2 = true
		h1 = true
	elif health == 2:
		h3 = false
		h2 = true
		h1 = true
	if health == 1:
		h3 = false
		h2 = false
		h1 = true

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
