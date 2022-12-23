extends TextBoxTrigger
tool
class_name CollectTrigger, "res://DialogTree/collect-trigger.svg"

func fire(data: Trigger.TriggerFireData):
	.fire(data)
	data.target.get_parent().remove_child(data.target)
	# TODO - add to inventory as well
