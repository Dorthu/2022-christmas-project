extends Trigger
class_name ToggleTrigger, "res://Resources/toggle-trigger.svg"

onready var toggle = $toggle

func fire(data: Trigger.TriggerFireData):
	if toggle:
		toggle.visible = data.hoverActive
	emit_signal("trigger_finished")
