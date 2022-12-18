extends Node

var dialog_controller = preload("res://Dialog/DialogController.tscn")

# stateful vars
var curController: DialogController = null
var dialog_tree: Dictionary = {}

func clicked(_viewport, event, handled, clickable):
	if not event is InputEventMouseButton or not event.pressed:
		return
	
	if handled:
		return
	
	if clickable.treeTarget.is_empty():
		push_warning(str("Clickable ", clickable, " not configured for dialog!"))
		return
	
	var target = clickable.get_node(clickable.treeTarget)
	if not target is Interactable:
		push_warning(str("Clickable ", clickable, " was not refernecing an Interactable with its Tree Target"))
		return
	
	target.handle_click(clickable, event)

func show_dialog(text):
	GameController.canPanCamera = false
	curController = dialog_controller.instance()
	GameController.root.add_ui_element(curController)
	curController.show_text(text)

func dialog_finished():
	GameController.canPanCamera = true
