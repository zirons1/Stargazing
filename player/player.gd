class_name Player
extends CharacterBody2D

signal player_controls_complete

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var laser_scene : PackedScene

@export var can_dash : bool

@export var disabled := false

const SPEED := 300.0
const DASH := 1500.0

const IFRAMES_TIME := 1.5
const DASH_THRESHOLD := 0.2
const DASH_TIME := 0.15

var down_dash_threshold := 0.0
var up_dash_threshold := 0.0

var iframes := false
var down_dashing := false
var up_dashing := false

@onready var controls_1: Sprite2D = $Controls1
@onready var controls_2: Sprite2D = $Controls2
@onready var controls_3: Sprite2D = $Controls3

var next := 1

func advance_controls() -> void:
	next += 1
	if next == 2:
		controls_1.hide()
		controls_2.show()
	if next == 3:
		controls_2.hide()
		controls_3.show()
	if next == 4:
		controls_3.hide()
		player_controls_complete.emit()
		return
	get_tree().create_timer(2.5).timeout.connect(advance_controls)

func _ready() -> void:
	Events.player_hit.connect(_on_player_hit)
	animated_sprite_2d.play("angry")

func battle_start() -> void:
	controls_1.show()
	get_tree().create_timer(2.5).timeout.connect(advance_controls)

func _physics_process(delta: float) -> void:
	if disabled:
		return
	
	if down_dashing:
		velocity.y = DASH
	elif up_dashing:
		velocity.y = -DASH
	elif Input.is_action_pressed("player_down"):
		velocity.y = SPEED
	elif Input.is_action_pressed("player_up"):
		velocity.y = -SPEED
	else:
		velocity.y = 0
	
	if Input.is_action_pressed("player_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("player_left"):
		velocity.x = -SPEED
	else:
		velocity.x = 0
	
	if can_dash:
		down_dash_threshold += delta
		if Input.is_action_just_pressed("player_down"):
			#print("atempting dash: " + str(down_dash_threshold))
			if down_dash_threshold < DASH_THRESHOLD:
				#print("ddddash")
				down_dashing = true
				get_tree().create_timer(DASH_TIME).timeout.connect(
					func(): 
						down_dashing = false
				)
			down_dash_threshold = 0.0
		
		up_dash_threshold += delta
		if Input.is_action_just_pressed("player_up"):
			#print("atempting dash: " + str(up_dash_threshold))
			if up_dash_threshold < DASH_THRESHOLD:
				#print("up dash")
				up_dashing = true
				get_tree().create_timer(DASH_TIME).timeout.connect(
					func(): 
						up_dashing = false
				)
			up_dash_threshold = 0.0

	move_and_slide()

func _on_player_hit() -> void:
	iframes = true
	animated_sprite_2d.play("iframes")
	get_tree().create_timer(IFRAMES_TIME).timeout.connect(
		func(): 
			animated_sprite_2d.play("paper")
			iframes = false
	)
