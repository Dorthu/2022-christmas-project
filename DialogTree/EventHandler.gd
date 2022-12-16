extends Node
tool
class_name EventHandler, "res://DialogTree/event_handler.svg"


export var defaultText: String

func clicked(_event):
	DialogSystem.show_dialog(defaultText)
