extends Node2D
signal advanceDay
class_name Level

onready var curRoom = $RoomHolder.get_child(0)
var curOverlay = null # if set, is an Overlay that is currently active
onready var initialRoom: String = curRoom.name

# rooms are the different background levels in the area
var roomNameMap: Dictionary = {}
# overlays show up over top of the current room, and are dismissed by clicking outside of themselves
var overlaynameMap: Dictionary = {}
# the fader is used to transition between days
var fader = preload("res://Resources/DayFade.tscn")
var checkEndOfDay = true

# The quests for this level, and their status (and int)
export var quests: Dictionary

func _ready():
	# hide all rooms except the default one
	for child in $RoomHolder.get_children():
		child.registerLevel(self)
		roomNameMap[child.name] = child
		if not child == curRoom:
			child.hide()
	
	for child in $OverlayHolder.get_children():
		overlaynameMap[child.name] = child
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

func show_overlay(name: String):
	if not name in overlaynameMap:
		push_error(str("show_overlay called with invalid target ", name))
		return
	
	# hide the clock
	GameController.root.toggle_clock(false)
	# disable the camera scrolling
	GameController.do_camera(false)
	# disable interaction in the current room
	curRoom.set_interactable(false)
	
	# center the overlay guard and the overlay itself
	var camera = GameController.root.get_camera()
	
	curOverlay = overlaynameMap[name]
	curOverlay.position = camera.position
	curOverlay.show()
	
	# pause this function right here until the overlay says its done
	yield(curOverlay, "exit_overlay")
	
	# pay the time cost
	GameController.add_time(curOverlay.timeCost)
	
	# remove the overlay
	curOverlay.hide()
	curOverlay = null
	
	# bring the clock back
	GameController.root.toggle_clock(true)
	# re-enable the camera
	GameController.do_camera(true)
	# re-enable interaction
	curRoom.set_interactable(true)

func end_day():
	# the day's ending, so stop looking for it
	checkEndOfDay = false
	
	# dismiss any active overlays immediately
	if curOverlay:
		curOverlay.force_dismiss()
	
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
	emit_signal("advanceDay")
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
