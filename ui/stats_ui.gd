class_name StatsUI
extends CanvasLayer

@onready var player_health: PlayerHealth = $HealthBar
@onready var enemy_health: EnemyHealth = $EnemyHealth

@onready var sun_health_name: AnimatedSprite2D = $SunHealthName
@onready var betel_health_name: AnimatedSprite2D = $BetelgeuseHealthName
@onready var crab_health_name: AnimatedSprite2D = $CrabHealthName
@onready var sag_health_name: AnimatedSprite2D = $SagHealthName

var curr : AnimatedSprite2D

func _ready() -> void:
	curr = null

func set_enemy_max(max : int) -> void:
	enemy_health.max_health = max
	enemy_health.reset_to_max()

func hide_curr() -> void:
	curr.stop()
	curr.hide()

func set_star_health_name(star : int) -> void:
	if curr:
		curr.stop()
		curr.hide()
	if star == 0:
		sun_health_name.show()
		sun_health_name.play()
		curr = sun_health_name
	elif star == 1:
		betel_health_name.show()
		betel_health_name.play()
		curr = betel_health_name
	elif star == 2:
		crab_health_name.show()
		crab_health_name.play()
		curr = crab_health_name
	elif star == 3:
		sag_health_name.show()
		sag_health_name.play()
		curr = sag_health_name
