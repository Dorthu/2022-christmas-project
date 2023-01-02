extends Trigger

class_name ChainTrigger

func fire(data: Trigger.TriggerFireData):
	for node in get_children():
		print("firing ", node)
		if node is Trigger:
			node.fire(data)
			yield(node, "trigger_finished")
	emit_signal("trigger_finished")
