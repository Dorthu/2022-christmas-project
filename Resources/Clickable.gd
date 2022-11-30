extends Node2D
tool
class_name Clickable

#: The key to use when selecting dialog for this Clickable
export(String) var dialogKey: String

func _ready():
	print(get_parent().connect("input_event", DialogSystem, "clicked", [self]))
	print("Registered input_event!")

func _get_configuration_warning():
	if not get_parent() is Area2D:
		return "Only an Area2D can be clickable!"
	return ""
