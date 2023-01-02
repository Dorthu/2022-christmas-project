extends Container

signal finished
class_name DayFader

onready var fader: AnimationPlayer = $Fader

func start():
	fader.play("Fade")
	print("Animation started!")
	yield(fader, "animation_finished")
	print("Animation done!")
	emit_signal("finished")
