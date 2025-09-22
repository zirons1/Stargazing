class_name Twinkle
extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var grav : float

var velocity : Vector2

#func _ready() -> void:
	#start(1)

func start(phase : int) -> void:
	if phase > 3:
		queue_free()
	
	animated_sprite_2d.play(str(phase))
	phase += 1
	get_tree().create_timer(0.8).timeout.connect(func(): start(phase))

func _physics_process(delta: float) -> void:
	position.x += velocity.x
	position.y += velocity.y
	
	velocity.x = velocity.x * grav
	velocity.y = velocity.y * grav
	
	if position.x <= -50:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body is not Player:
		return
	
	var player = body as Player
	if player.iframes:
		return
	
	Events.player_hit.emit()
	queue_free()
