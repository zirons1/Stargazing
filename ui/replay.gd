extends AnimatedSprite2D

@export var menu_scene : PackedScene

func _ready() -> void:
	play()

func _on_again_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		get_tree().reload_current_scene()

func _on_menu_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		get_tree().change_scene_to_packed(menu_scene)
