extends Node
signal trigger_finished # declared for subclasses to use
class_name Trigger

# a class to contain all information needed by triggers to fire
class TriggerFireData:
	var target: Node2D
	var event
	var hoverActive: bool
	
	func _init(targetData: Node2D, eventData, hoverActiveData: bool):
		self.target = targetData
		self.event = eventData
		self.hoverActive = hoverActiveData

# static functions for created trigger fire events
static func new_click_event(target: Node2D, event):
	return TriggerFireData.new(target, event, false)

static func new_hover_event(active: bool):
	return TriggerFireData.new(null, null, active)

# this must be implemented by all trigger types
func fire(_data: TriggerFireData) -> bool:
	push_warning("do_trigger called on base Trigger class!")
	return false
