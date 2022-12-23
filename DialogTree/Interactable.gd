extends Node
tool
class_name Interactable, "res://DialogTree/interactable.svg"

# TODO - these cause warnings
onready var clickEvent = $click
onready var hoverEvent = $hover

func handle_click(target, event):
	if clickEvent:
		clickEvent.fire(Trigger.new_click_event(target, event))

func handle_hover(active):
	if hoverEvent:
		hoverEvent.fire(Trigger.new_hover_event(active))

func _get_configuration_warning():
	if not $click:
		return "Requires child node named 'click'"
	elif not $click is Trigger:
		return "'click' child must be of type 'EventHandler'"
	return ""
