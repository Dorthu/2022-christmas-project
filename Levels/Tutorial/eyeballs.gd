extends Sprite

onready var anchor: Vector2 = position
onready var global_pos: Vector2 = global_position
const MAX_DISTANCE: float = 10.0
const DISTANCE_MULTIPLIER_X: float = 0.025
const DISTANCE_MULTIPLIER_Y: float = 0.01

func _ready():
	print(anchor)
	print(global_pos)

func _process(delta):
	# pull toward the mouse
	var mouse_pos = get_global_mouse_position()
	position = Vector2(
		anchor.x + (DISTANCE_MULTIPLIER_X * (mouse_pos.x - global_pos.x)),
		anchor.y + (DISTANCE_MULTIPLIER_Y * (mouse_pos.y - global_pos.y))
	).limit_length(MAX_DISTANCE)
	
