extends Trigger
tool
class_name TextBoxTrigger, "res://DialogTree/text-box-trigger.svg"


export var defaultText: String

func fire(_data: Trigger.TriggerFireData):
	DialogSystem.show_dialog(defaultText)
