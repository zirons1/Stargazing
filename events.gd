extends Node

const PLAYER_MAX_HEALTH := 3
const PLAYER_START := Vector2(90, 300)

var player_health = PLAYER_MAX_HEALTH
var player_pos = PLAYER_START

func reset_player_health() -> void:
	player_health = PLAYER_MAX_HEALTH

func reset_player_pos() -> void:
	player_pos = PLAYER_START

signal player_hit

signal star_hit
signal star_dead

signal health_zero
