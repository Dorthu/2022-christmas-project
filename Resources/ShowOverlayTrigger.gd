extends Trigger
class_name ShowOverlayTrigger

export var OverlayName: String

func fire(_data: Trigger.TriggerFireData):
	GameController.currentLevel.show_overlay(OverlayName)
	emit_signal("trigger_finished")
