class_name PlayerHealth
extends HBoxContainer

@onready var heart_1: AnimatedSprite2D = $Heart1
@onready var heart_2: AnimatedSprite2D = $Heart2
@onready var heart_3: AnimatedSprite2D = $Heart3

@export var full_anim : String = "default_paper"
@export var empty_anim : String = "empty_paper"

var h1 : bool = true : 
	set(val):
		if val:
			heart_1.play(full_anim)
		else:
			heart_1.play(empty_anim)
		h1 = val

var h2 : bool = true : 
	set(val):
		if val:
			heart_2.play(full_anim)
		else:
			heart_2.play(empty_anim)
		h2 = val

var h3 : bool = true : 
	set(val):
		if val:
			heart_3.play(full_anim)
		else:
			heart_3.play(empty_anim)
		h3 = val

func _ready() -> void:
	Events.player_hit.connect(_on_player_hit)
	heart_1.play(full_anim)
	heart_2.play(full_anim)
	heart_3.play(full_anim)

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
	Events.player_health -= 1
	if h3:
		h3 = false
	elif h2:
		h2 = false
	elif h1:
		h1 = false
		Events.health_zero.emit()
