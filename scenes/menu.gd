extends Node2D

@export var sun_battle : PackedScene
@export var betelguese_battle : PackedScene
@export var crab_battle : PackedScene
@export var sag_battle : PackedScene

@onready var sun_menu: AnimatedSprite2D = $SunMenu
@onready var betel_menu: AnimatedSprite2D = $BetelMenu
@onready var crab_menu: AnimatedSprite2D = $CrabMenu
@onready var sag_menu: AnimatedSprite2D = $SagMenu

func _ready() -> void:
	sun_menu.play()
	betel_menu.play()
	crab_menu.play()
	sag_menu.play()

func _on_sun_panel_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		get_tree().change_scene_to_packed(sun_battle)

func _on_betelguese_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		get_tree().change_scene_to_packed(betelguese_battle)

func _on_crab_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		get_tree().change_scene_to_packed(crab_battle)

func _on_sag_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		get_tree().change_scene_to_packed(sag_battle)
