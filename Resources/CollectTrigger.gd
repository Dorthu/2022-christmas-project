extends TextBoxTrigger
tool
class_name CollectTrigger, "res://Resources/collect-trigger.svg"

export var PickupItem: NodePath

func fire(data: Trigger.TriggerFireData) -> bool:
	.fire(data)
	handle_collect_item()
	data.target.get_parent().remove_child(data.target)
	emit_signal("trigger_finished")
	return true

func handle_collect_item():
	if not is_inside_tree():
		print("I am not in the scene tree???")
	var item = get_node(PickupItem)
	if item == null:
		push_warning(str("CollectTrigger ", name, " of ", get_parent().name, " had invalid path ", PickupItem, " set for pickup!"))
	elif item is InventoryItem:
		item.get_parent().remove_child(item)
		GameController.collect_item(item)
	else:
		push_warning(str("CollectTrigger ", name, " of ", get_parent().name, " did not have a valid InventoryItem assigned for pickup!"))
