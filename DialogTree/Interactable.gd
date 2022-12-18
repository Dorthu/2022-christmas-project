extends Node
tool
class_name Interactable, "res://DialogTree/interactable.svg"

onready var clickEvent = $click

func handle_click(target, event):
	if clickEvent:
		clickEvent.clicked(target, event)

func _get_configuration_warning():
	if not $click:
		return "Requires child node named 'click'"
	elif not $click is Trigger:
		return "'click' child must be of type 'EventHandler'"
	return ""
