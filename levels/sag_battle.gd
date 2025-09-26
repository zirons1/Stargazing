extends Node2D

@export var laser_scene: PackedScene
@export var atom_scene: PackedScene

@export var eyeballs_scene : PackedScene

@onready var player: CharacterBody2D = $Player
@onready var sag_a: Sag = $SagA

@onready var replay: AnimatedSprite2D = $Replay

@onready var stats_ui: StatsUI = $StatsUI

@onready var atom_timer: Timer = $AtomTimer
@onready var creep_timer: Timer = $CreepTimer

const ATOM_SPEED : int = -8

var pos_arr := [100, 250, 400, 550]

var last_pos : int = 0

var flip : int = 1

var stop := false

var curr_sag_health : float

func _ready() -> void:
	Events.health_zero.connect(game_over)
	Events.star_dead.connect(victory)
	stats_ui.set_enemy_max(sag_a.health)
	stats_ui.set_star_health_name(3)
	Events.heal_health()
	stats_ui.player_health.set_health(Events.player_health)
	atom_timer.timeout.connect(go_atom)
	creep_timer.timeout.connect(creep_timeout)
	player.position = Events.player_pos
	curr_sag_health = sag_a.health * .9

func creep_timeout() -> void:
	if stats_ui.enemy_health.value < curr_sag_health:
		print("Creep_")
		sag_a.creep()
		curr_sag_health -= sag_a.health / 10

func go_atom() -> void:
	if stop:
		return
	
	var atom = atom_scene.instantiate()
	var index = randi_range(0, 2)
	var new_pos = pos_arr[index]
	pos_arr.remove_at(index)
	if last_pos:
		pos_arr.append(last_pos)
	last_pos = new_pos
	var vector := Vector2(1000, new_pos)
	atom.position = vector
	atom.velocity = Vector2(ATOM_SPEED, 0)
	add_child(atom)

func _input(event: InputEvent) -> void:
	if stop:
		return
	
	if event.is_action_pressed("space"):
		var laser := laser_scene.instantiate()

		flip = -1 if flip == 1 else 1
		laser.position = Vector2(player.position.x + 10, player.position.y + (45 * flip))
		laser.velocity = Vector2(10, 0)

		add_child(laser)

func game_over() -> void:
	print("game over")
	stop = true
	player.disabled = true
	replay.show()
	Events.reset_player_health()
	Events.reset_player_pos()
	
	for attack in get_tree().get_nodes_in_group("attacks"):
		attack.queue_free()

func victory() -> void:
	print("victory")
	stats_ui.hide()
	stop = true
	Events.player_pos = player.position
	Events.reset_player_health()
	
	for attack in get_tree().get_nodes_in_group("attacks"):
		attack.queue_free()

	sag_a.move()
	sag_a.end_move.connect(finale)

func finale() -> void:
	#get_tree().change_scene_to_file(path_to_sag)
	var eye_scene := eyeballs_scene.instantiate()
	add_child(eye_scene)
	move_child(player, get_child_count())
