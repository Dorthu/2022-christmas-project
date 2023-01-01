extends MarginContainer

onready var minuteHand = $Viewport/minuteHand
var ROTATION_MOD_DEGREES = -90
var MINUTES_TO_DEGREES = 360.0 / 60.0 # degrees / minutes per hour

func _process(_delta):
	if not visible:
		return

	var lastRotation = minuteHand.rotation_degrees	
	minuteHand.rotation_degrees = -1 * (ROTATION_MOD_DEGREES + (GameController.currentTime * MINUTES_TO_DEGREES))

	if lastRotation != minuteHand.rotation_degrees:
		print("New rotation degrees is ", minuteHand.rotation_degrees)
