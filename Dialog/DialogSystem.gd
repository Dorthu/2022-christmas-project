extends Node

# func _on_DialogSystem_DialogActive(active: bool, controller: DialogController = null):
signal dialogActive

var dialog_controller = preload("res://Dialog/DialogController.tscn")

# stateful vars
var curController: DialogController = null
var dialog_tree: Dictionary = {}

func show_dialog(dialogEntry: DialogEntry):
	curController = dialog_controller.instance()
	GameController.root.add_ui_element(curController)
	curController.show_entry(dialogEntry)
	emit_signal("dialogActive", true, curController)

func dialog_finished():
	emit_signal("dialogActive", false, curController)
