extends Control

class_name Inventory

# adds an item to the inventory - ezpz
func add_item(item: InventoryItem):
	print("Adding item ", item, "to ", $MarginContainer/Items)
	$MarginContainer/Items.add_child(item)
