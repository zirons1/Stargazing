extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	animated_sprite_2d.play()

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
