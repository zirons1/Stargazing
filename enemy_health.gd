extends TextureProgressBar

@export var report : bool
@export var max_health : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = max_health
	value = max_health
	Events.star_hit.connect(_on_star_hit)

func _on_star_hit() -> void:
	value -= 1
	if value <= 0:
		Events.star_dead.emit()
