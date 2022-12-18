extends Node2D
tool
class_name Clickable

#: The node in this scene's DialogTree which represents this clickable
export var treeTarget: NodePath

func _get_configuration_warning():
	#if treeTarget.is_empty():
	#	return "Must set a behavior target for this clickable!"
	#elif not get_node(treeTarget) is Trigger:
	#	return "Target must be an Interactable node!"
	return ""

func _on_Area2D_input_event(viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Clickable was clicked!")
		DialogSystem.clicked(viewport, event, false, self)
