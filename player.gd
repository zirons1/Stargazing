class_name Player
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var laser_scene : PackedScene

var iframes := false

const IFRAMES_SECS := 1.5
const SPEED := 300.0

func _ready() -> void:
	Events.player_hit.connect(_on_player_hit)
	animated_sprite_2d.play("paper")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("player_down") or Input.is_action_pressed("player_down"):
		velocity.y = SPEED
		
	elif Input.is_action_just_pressed("player_up") or Input.is_action_pressed("player_up"):
		velocity.y = -SPEED
	
	else:
		velocity.y = 0
	
	if Input.is_action_just_pressed("player_right") or Input.is_action_pressed("player_right"):
		velocity.x = SPEED
		
	elif Input.is_action_just_pressed("player_left") or Input.is_action_pressed("player_left"):
		velocity.x = -SPEED
	
	else:
		velocity.x = 0

	move_and_slide()

func _on_player_hit() -> void:
	iframes = true
	animated_sprite_2d.play("iframes")
	get_tree().create_timer(1.5).timeout.connect(
		func(): 
			animated_sprite_2d.play("paper")
			iframes = false
	)
