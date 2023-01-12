extends Camera2D

var CAMERA_SPEED: float = 300.0
var SCREEN_SIZE: Vector2 = Vector2(1024, 600)
var PAN_EDGE_WIDTH: float = SCREEN_SIZE.x / 3
var PAN_SPEED_DIVISOR: float = PAN_EDGE_WIDTH - 100

# camera controlling variables; the camera can be disabled in the following ways:
#  - if the GameController tells us not to active
#  - if a DialogController has control of the screen
# the default configuration here enables the camera; any other permutation diables it
var cameraActive: bool = true
var dialogActive: bool = false

func _ready():
	position = Vector2(SCREEN_SIZE.x/2, SCREEN_SIZE.y/2)
	var _res = DialogSystem.connect("dialogActive", self, "_on_DialogSystem_DialogActive")
	_res = GameController.connect("toggle_camera", self, "_on_GameController_ToggleCamera")

func _on_DialogSystem_DialogActive(active: bool, _controller: DialogController = null):
	# when a dialog is active, the camera shouldn't update (and thereforce panning should stop)
	dialogActive = active
	
func _on_GameController_ToggleCamera(active: bool):
	cameraActive = active

func _process(delta: float):
	if not cameraActive or dialogActive:
		# only run the camera if its active and no dialog is on the screen
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
