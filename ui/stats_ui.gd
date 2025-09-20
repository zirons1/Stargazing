class_name StatsUI
extends CanvasLayer

@onready var player_health: PlayerHealth = $HealthBar
@onready var enemy_health: EnemyHealth = $EnemyHealth

func set_enemy_max(max : int) -> void:
	enemy_health.max_health = max
	enemy_health.reset_to_max()
