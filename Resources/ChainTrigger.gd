extends Trigger

class_name ChainTrigger

func fire(data: Trigger.TriggerFireData) -> bool:
	var children = get_children()
	for node in children:
		print("firing ", node)
		if node is Trigger:
			var shouldWait = node.fire(data)
			if shouldWait:
				yield(node, "trigger_finished")
			print("Done ", node)
	emit_signal("trigger_finished")
	return true
