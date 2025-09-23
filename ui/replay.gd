extends AnimatedSprite2D

@export var path_to_menu_scene : String

func _ready() -> void:
	play()

func _on_again_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		get_tree().reload_current_scene()

func _on_menu_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		get_tree().change_scene_to_file(path_to_menu_scene)
