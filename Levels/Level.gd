extends Node2D

class_name Level

onready var curRoom = $RoomHolder.get_child(0)
var roomNameMap: Dictionary = {}

func _ready():
	# hide all rooms except the default one
	for child in $RoomHolder.get_children():
		roomNameMap[child.name] = child
		if not child == curRoom:
			child.hide()
	
	var _res = GameController.connect("timeChanged", self, "_on_GameController_TimeChanged")

func get_room_width():
	return curRoom.width

func change_room(target: String):
	# expects to be called with a room name found in childNameMap; pushed a warningo therwise
	if not target in roomNameMap:
		push_error(str("change_room called with invalid target ", target))
		return
	
	# do the swap
	# TODO: maybe tweak camera position too
	curRoom.hide()
	curRoom = roomNameMap[target]
	curRoom.show()

func _on_GameController_TimeChanged(newTime: float):
	if newTime >= 45.0:
		DialogSystem.show_dialog($dayEnd)
		GameController.reset_time()
