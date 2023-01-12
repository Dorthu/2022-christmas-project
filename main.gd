extends Node2D

class_name main

func _ready():
	GameController.currentLevel = $LevelContainer/Level
	GameController.root = self

func add_ui_element(node: Control):
	$UI.add_child(node)

func remove_ui_element(node: Control):
	$UI.remove_child(node)

func toggle_clock(show: bool):
	$UI/Overlay.toggle_clock(show)

func get_camera():
	return $Camera
