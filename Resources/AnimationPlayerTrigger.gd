extends Trigger

class_name AnimationPlayerTrigger

export var animationName: String
onready var animationPlayer: AnimationPlayer = $animation

func fire(_data: Trigger.TriggerFireData):
	animationPlayer.play(animationName)
	yield(animationPlayer, "animation_finished")
	emit_signal("trigger_finished")
