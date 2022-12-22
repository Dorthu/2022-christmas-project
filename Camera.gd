extends Camera2D

var CAMERA_SPEED: float = 200.0
var SCREEN_SIZE: Vector2 = Vector2(1024, 600)
var PAN_EDGE_WIDTH: float = SCREEN_SIZE.x / 3
var PAN_SPEED_DIVISOR: float = PAN_EDGE_WIDTH - 100

func _ready():
	position = Vector2(SCREEN_SIZE.x/2, SCREEN_SIZE.y/2)

func _process(delta: float):
	if not GameController.canPanCamera:
		return
	
	var roomWidth = GameController.currentLevel.get_room_width()
	var mousePos = get_global_mouse_position()
	var mouseX = mousePos.x - self.position.x + SCREEN_SIZE.x/2
	var speedMod = 1
	
	# move if near the edges
	if mouseX < PAN_EDGE_WIDTH:
		speedMod = (PAN_EDGE_WIDTH - mouseX) / PAN_SPEED_DIVISOR
		position.x -= CAMERA_SPEED * delta * speedMod
	elif mouseX > SCREEN_SIZE.x - PAN_EDGE_WIDTH:
		speedMod = (mouseX - (SCREEN_SIZE.x - PAN_EDGE_WIDTH)) / PAN_SPEED_DIVISOR
		position.x += CAMERA_SPEED * delta * speedMod
	
	# clamp to within the bounds of the room
	if position.x - (SCREEN_SIZE.x / 2) < 0:
		position.x = SCREEN_SIZE.x / 2
	elif position.x + SCREEN_SIZE.x / 2 > roomWidth:
		position.x = roomWidth - SCREEN_SIZE.x / 2
