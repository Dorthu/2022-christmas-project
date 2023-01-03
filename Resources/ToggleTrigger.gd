extends Trigger
class_name ToggleTrigger, "res://Resources/toggle-trigger.svg"

onready var toggle = $toggle

func fire(data: Trigger.TriggerFireData) -> bool:
	if toggle:
		toggle.visible = data.hoverActive
	return false
