extends Node2D
signal toggleClickables
class_name LevelRoom

onready var width = $Background.texture.get_width()

# this is populated with nodes that display on only one day of the week; they advance
# in order and wrap when completed
var dayNodes: Array = []
var curDay: int = 0

func _ready():
	# populate day nodes if we have such a child present
	if has_node("DayNodes"):
		dayNodes = $DayNodes.get_children()
		
		# hide all days except the first
		for node in dayNodes:
			node.hide()
		dayNodes[0].show()

# sets up listeners for our parent Level
func registerLevel(level: Level):
	var _r = level.connect("advanceDay", self, "_on_Level_AdvanceDay")

func _on_Level_AdvanceDay():
	advanceDay()

# advanceDay is a callback triggered by our level's advanceDay event
func advanceDay():
	if len(dayNodes) == 0:
		# if we don't have day-specific nodes, ignore this
		return
	
	dayNodes[curDay].hide()
	curDay += 1
	if curDay >= len(dayNodes):
		curDay = 0
	dayNodes[curDay].show()

# set_interactable is used when overlays are shown to enable/disable all clickables
# in the room; this allows overlays to be shown over top of the room without having
# click events trigger clickables underneath
func set_interactable(interactable: bool):
	emit_signal("toggleClickables", interactable)
