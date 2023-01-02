extends Container

signal finished
class_name DayFader

onready var fader: AnimationPlayer = $Fader

func fade_in():
	fader.play("Fade")
	yield(fader, "animation_finished")
	emit_signal("finished")

func fade_out():
	fader.play_backwards("Fade")
	yield(fader, "animation_finished")
	emit_signal("finished")
