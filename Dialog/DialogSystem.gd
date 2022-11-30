extends Node

var dialog_controller = preload("res://Dialog/DialogController.tscn")

# stateful vars
var curController: DialogController = null

func _ready():
	print("Dialog system exists")

func clicked(_viewport, event, handled, clickable):
	if not event is InputEventMouseButton or not event.pressed:
		return
		
	if handled:
		return
	
	if not clickable.dialogKey:
		push_warning(str("Clickable ", clickable, " not configured for dialog!"))

	curController = dialog_controller.instance()
	get_tree().root.add_child(curController)
	curController.show_text(clickable.dialogKey)
