extends Node

var show_controls_once := true

const PLAYER_MAX_HEALTH := 3
const PLAYER_START := Vector2(122, 377)

var player_health = PLAYER_MAX_HEALTH
var player_pos = PLAYER_START

func reset_player_health() -> void:
	player_health = PLAYER_MAX_HEALTH

func reset_player_pos() -> void:
	player_pos = PLAYER_START

func heal_health() -> void:
	if player_health >= PLAYER_MAX_HEALTH:
		return
	elif player_health <= 0:
		health_zero.emit()
	else:
		player_health += 1

signal player_hit

signal star_hit
signal star_dead

signal health_zero
