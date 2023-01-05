"""
This is the main controller for the entire game, which handles management of all systems and trasitions
between levels.  This controller is a globally-referencable singleton.
"""
extends Node
signal timeChanged
signal toggle_camera

var currentLevel: Level = null
var root: main = null

# the current time; 0 = 5:30 AM, each numeric value is one minute after 5:30 AM
# (so 45.0 is 6:15 AM)
var currentTime: float = 0

# the current day in the level; each level has a number of days it has to be finished in
var currentDay: int = 0

func add_time(time: float):
	currentTime += time
	if time > 0:
		emit_signal("timeChanged", currentTime)

func advance_day():
	currentTime = 0.0
	currentDay += 1

func do_camera(active: bool):
	emit_signal("toggle_camera", active)
