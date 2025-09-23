extends Node2D

@export var menu : PackedScene

@onready var title: AnimatedSprite2D = $Title
@onready var sun: AnimatedSprite2D = $Sun
@onready var betel: AnimatedSprite2D = $Betel
@onready var crab: AnimatedSprite2D = $Crab
@onready var play_sprite: AnimatedSprite2D = $PlaySprite
@onready var speech: AnimatedSprite2D = $Speech
@onready var credits_z: AnimatedSprite2D = $CreditsZ
@onready var credits_b: AnimatedSprite2D = $CreditsB

func _ready() -> void:
	title.play()
	sun.play()
	betel.play()
	crab.play()
	play_sprite.play("bw")
	speech.play()
	credits_z.play()
	credits_b.play()

func _on_play_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		print("click")
		get_tree().change_scene_to_packed(menu)
