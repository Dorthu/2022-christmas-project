extends Trigger
tool
class_name TextBoxTrigger, "res://DialogTree/event_handler.svg"


export var defaultText: String

func clicked(_target: Node2D, _event):
	DialogSystem.show_dialog(defaultText)
