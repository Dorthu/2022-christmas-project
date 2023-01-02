extends Node

# func _on_DialogSystem_DialogActive(active: bool, controller: DialogController = null):
signal dialogActive

var dialog_controller = preload("res://Dialog/DialogController.tscn")

# stateful vars
var curController: DialogController = null
var dialog_tree: Dictionary = {}

func show_dialog(dialogEntry: DialogEntry):
	if curController != null:
		push_warning("Attempted to show dialog while another dialog was active!")
		return
	
	curController = dialog_controller.instance()
	GameController.root.add_ui_element(curController)
	curController.show_entry(dialogEntry)
	emit_signal("dialogActive", true, curController)

func dialog_finished():
	var dismissing = curController
	curController = null
	emit_signal("dialogActive", false, dismissing)

func force_dismiss_dialog():
	if curController != null:
		curController.dismiss()
