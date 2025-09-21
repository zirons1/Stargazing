extends Node2D

@export var sun_battle : PackedScene
@export var betelguese_battle : PackedScene

@onready var sun_menu: AnimatedSprite2D = $SunMenu
@onready var betel_menu: AnimatedSprite2D = $BetelMenu

func _ready() -> void:
	sun_menu.play()
	betel_menu.play()

func _on_sun_panel_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		print("click")
		get_tree().change_scene_to_packed(sun_battle)

func _on_betelguese_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		print("click")
		get_tree().change_scene_to_packed(betelguese_battle)
