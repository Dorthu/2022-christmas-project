extends TextBoxTrigger
tool
class_name CollectTrigger, "res://DialogTree/event_handler.svg"

func clicked(target: Node2D, event):
	.clicked(target, event)
	target.get_parent().remove_child(target)
	# TODO - add to inventory as well
