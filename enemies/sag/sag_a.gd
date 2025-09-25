class_name Sag
extends CharacterBody2D

signal end_move

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d_1: AnimatedSprite2D = $AnimatedSprite2D1
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2

@onready var timer: Timer = $Timer

@export var health : int

var disabled := false

var tween : Tween

func _ready() -> void:
	animated_sprite_2d.play()
	animated_sprite_2d_1.play()
	animated_sprite_2d_2.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if disabled:
		return
	#print("player_hit sun")
	Events.player_hit.emit()

func creep() -> void:
	if disabled:
		return
	
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "position:x", position.x - 100, 2.0)

func move() -> void:
	disabled = true
	
	if tween:
		tween.kill()
		
	tween = create_tween()
	tween.tween_property(self, "position", Vector2.LEFT * 2200, 2.0)
	tween.finished.connect(func(): end_move.emit())
