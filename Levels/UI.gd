extends Control

onready var clock = $HUD/Clock

# listen for signals from our singletons
func _ready():
	var _res = DialogSystem.connect("dialogActive", self, "_on_DialogSystem_DialogActive")
	_res = GameController.connect("collect_item", self, "_on_GameController_CollectItem")

func _on_DialogSystem_DialogActive(active: bool, controller: DialogController = null):
	if not active:
		GameController.add_time(controller.getEntry().timeCost)

func toggle_clock(show: bool):
	if show:
		clock.show()
	else:
		clock.hide()

func _on_GameController_CollectItem(item: InventoryItem):
	$HUD/Inventory/Inventory.add_item(item)
