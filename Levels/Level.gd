extends Node2D

class_name Level

onready var curRoom = $RoomHolder.get_child(0)
onready var initialRoom: String = curRoom.name
var roomNameMap: Dictionary = {}
var fader = preload("res://Resources/DayFade.tscn")
var checkEndOfDay = true

# The quests for this level, and their status (and int)
export var quests: Dictionary

func _ready():
	# hide all rooms except the default one
	for child in $RoomHolder.get_children():
		roomNameMap[child.name] = child
		if not child == curRoom:
			child.hide()
	
	var _res = GameController.connect("timeChanged", self, "_on_GameController_TimeChanged")
	
	# set all quests to just started
	for key in quests.keys():
		quests[key] = 0

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

func end_day():
	# the day's ending, so stop looking for it
	checkEndOfDay = false
	
	# show the day end dialog box
	DialogSystem.show_dialog($dayEnd)
	
	# fade to black
	var fade = fader.instance()
	GameController.root.add_ui_element(fade)
	fade.fade_in()
	yield(fade, "finished")
	
	# remove the dialog box, reset room, and fade back in
	DialogSystem.force_dismiss_dialog()
	GameController.advance_day()
	change_room(initialRoom) # TODO - move camera around too
	fade.fade_out()
	yield(fade, "finished")
	
	# and we're done
	GameController.root.remove_ui_element(fade)
	checkEndOfDay = true

func _on_GameController_TimeChanged(newTime: float):
	if checkEndOfDay and newTime >= 45.0:
		end_day()

func set_quest(name: String, stage: int):
	if name in quests:
		quests[name] = stage
	else:
		push_warning("Requested setting non-existent quest " + name + " to " + str(stage))

func get_quest_status(name: String) -> int:
	if name in quests:
		return quests[name]
	return -1
