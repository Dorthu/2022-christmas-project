extends Control

onready var clock = $HUD/Clock

func _ready():
	var _res = DialogSystem.connect("dialogActive", self, "_on_DialogSystem_DialogActive")

func _on_DialogSystem_DialogActive(active: bool, controller: DialogController = null):
	if not active:
		GameController.add_time(controller.getEntry().timeCost)

func toggle_clock(show: bool):
	if show:
		clock.show()
	else:
		clock.hide()
