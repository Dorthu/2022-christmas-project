extends Trigger
tool
class_name TextBoxTrigger, "res://Resources/text-box-trigger.svg"


export var dialogKey: NodePath

func fire(_data: Trigger.TriggerFireData) -> bool:
	var entry = get_node(dialogKey)
	DialogSystem.show_dialog(entry)
	
	yield(DialogSystem, "dialogActive")
	emit_signal("trigger_finished")
	return true

func _get_configuration_warning() -> String:
	if dialogKey == "":
		return "No Dialog Key set!"
	return ""
