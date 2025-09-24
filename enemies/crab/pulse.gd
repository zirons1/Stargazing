class_name Pulse
extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var beam_scene : PackedScene
@export var spinner_scene : PackedScene

const SPINNER_SPEED := -12

var do_beam := true

func _ready() -> void:
	animated_sprite_2d.play()
	
	if do_beam:
		get_tree().create_timer(1.0).timeout.connect(beam_up)
	else:
		get_tree().create_timer(2.0).timeout.connect(
			func():
			queue_free()
		)
		

func beam_up() -> void:
	var beam := beam_scene.instantiate()
	beam.on_body_entered.connect(_on_body_entered)
	add_child(beam)
	
	get_tree().create_timer(1.0).timeout.connect(
		func():
		remove_child(beam)
		queue_free()
	)

func _on_body_entered(body: Node) -> void:
	if body is not Player:
		return
	
	var player = body as Player
	if player.iframes:
		return
	
	Events.player_hit.emit()
