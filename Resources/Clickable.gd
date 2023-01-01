extends Node2D
tool
class_name Clickable

var clickEvent: Trigger = null
var hoverEvent: Trigger = null

func _ready():
	for c in get_children():
		if c.name == "click":
			clickEvent = c
		elif c.name == "hover":
			hoverEvent = c

func _get_configuration_warning():
	#if treeTarget.is_empty():
	#	return "Must set a behavior target for this clickable!"
	#elif not get_node(treeTarget) is Trigger:
	#	return "Target must be an Interactable node!"
	return ""

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if clickEvent and event is InputEventMouseButton and event.pressed:
		clickEvent.fire(Trigger.new_click_event(self, event))

func _on_Area2D_mouse_entered():
	if hoverEvent:
		hoverEvent.fire(Trigger.new_hover_event(true))

func _on_Area2D_mouse_exited():
	if hoverEvent:
		hoverEvent.fire(Trigger.new_hover_event(false))
