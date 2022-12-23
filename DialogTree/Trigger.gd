extends Node
class_name Trigger

# a class to contain all information needed by triggers to fire
class TriggerFireData:
	var target: Node2D
	var event
	var hoverActive: bool
	
	func _init(target: Node2D, event, hoverActive: bool):
		self.target = target
		self.event = event
		self.hoverActive = hoverActive

# static functions for created trigger fire events
static func new_click_event(target: Node2D, event):
	return TriggerFireData.new(target, event, false)

static func new_hover_event(active: bool):
	return TriggerFireData.new(null, null, active)

# this must be implemented by all trigger types
func fire(_data: TriggerFireData):
	push_error("Base Trigger type recieved fire event!")
