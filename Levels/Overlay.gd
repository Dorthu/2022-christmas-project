extends Node2D
signal exit_overlay
class_name Overlay

onready var bg: Sprite = $Background
const SCREEN_HEIGHT = 600 # TODO de-dupe
const SCREEN_WIDTH = 1024

func _ready():
	# set up two dynamic Area2Ds on either side of the background to ensure that clicks
	# outside of the background are registered as exiting the overlay
	var leftBound = Area2D.new()
	var rightBound = Area2D.new()
	
	var bgTextureWidth = (bg.texture.get_width() * bg.scale.x)
	var boundWidth = (SCREEN_WIDTH - bgTextureWidth) / 2.0
	
	# set up collision shapes for the left and right bondaries, with their extents being half the desired
	# size of the clickable areas (the space that will be to the left and right of the background texture)
	var collisionShapeL = CollisionShape2D.new()
	collisionShapeL.shape = RectangleShape2D.new()
	collisionShapeL.shape.set_extents(Vector2(boundWidth/2, SCREEN_HEIGHT/2))
	leftBound.add_child(collisionShapeL)
	
	var collisionShapeR = CollisionShape2D.new()
	collisionShapeR.shape = RectangleShape2D.new()
	collisionShapeR.shape.set_extents(Vector2(boundWidth/2, SCREEN_HEIGHT/2))
	rightBound.add_child(collisionShapeR)
	
	# position our boundaries to the left and right of the background texture appropriately; these should
	# be relative to the overlay's origin and not real screen space
	leftBound.position.x = -1 * bgTextureWidth/2 - boundWidth/2
	rightBound.position.x = bgTextureWidth/2 + boundWidth/2
	
	# set up events for the boundaries
	leftBound.connect("input_event", self, "_on_Bounds_InputEvent")
	rightBound.connect("input_event", self, "_on_Bounds_InputEvent")
	
	# add them to this scene
	add_child(leftBound)
	add_child(rightBound)

func _on_Bounds_InputEvent(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		# this is a hack to ensure that other shapes don't handle this event by making it look like a
		# mouse up event I don't care about right now.  If I ever care about those, I'll likely regret
		# doing this o_o
		event.pressed = false
		emit_signal("exit_overlay")
