extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var beam_scene : PackedScene

var spin := false

var curr_beam

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play()
	countdown()

func countdown() -> void:
	get_tree().create_timer(1.0).timeout.connect(
		func():
		animated_sprite_2d.stop()
	)
	get_tree().create_timer(2.0).timeout.connect(
		func():
		animated_sprite_2d.play()
		var beam := beam_scene.instantiate()

		beam.on_body_entered.connect(_on_body_entered)
		#beam.position = position

		add_child(beam)
		curr_beam = beam
	)
	get_tree().create_timer(5.0).timeout.connect(
		func():
		remove_child(curr_beam)
		queue_free()
	)

func _on_body_entered(body: Node) -> void:
	if body is not Player:
		return
	
	var player = body as Player
	if player.iframes:
		return
	
	Events.player_hit.emit()
