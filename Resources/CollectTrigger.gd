extends TextBoxTrigger
tool
class_name CollectTrigger, "res://Resources/collect-trigger.svg"

func fire(data: Trigger.TriggerFireData):
	._do_trigger(data)
	data.target.get_parent().remove_child(data.target)
	# TODO - add to inventory as well
	emit_signal("trigger_finished")
