extends Node2D

@export var path_to_menu : String

@onready var text_1: AnimatedSprite2D = $Text1
@onready var text_2: AnimatedSprite2D = $Text2
@onready var eyes: Node2D = $Eyes
@onready var menu: AnimatedSprite2D = $Menu
@onready var menu_panel: Panel = $MenuPanel

var count := 0

func _ready() -> void:
	text_1.play()
	text_2.play()
	for eye in eyes.get_children():
		get_tree().create_timer(randf_range(0.5, 1.5)).timeout.connect(
			func():
				eye.show()
				eye.play()
				eye_appear(eye)
		)

func eye_appear(eye : AnimatedSprite2D) -> void:
	get_tree().create_timer(randf_range(0.5, 0.8)).timeout.connect(
		func():
			eye.play("open")
			reveal_text()
	)

func reveal_text() -> void:
	count += 1
	if count >= 11:
		get_tree().create_timer(2.0).timeout.connect(
			func():
				text_1.show()
				text_1.play()
				text_2.show()
				text_2.play()
				menu.show()
				menu.play()
				menu_panel.show()
		)


func _on_menu_panel_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		get_tree().change_scene_to_file(path_to_menu)
