extends Node2D

class_name main

func _ready():
	GameController.currentLevel = $LevelContainer/Level
	GameController.root = self

func add_ui_element(node: Control):
	$UI.add_child(node)

func remove_ui_element(node: Control):
	$UI.remove_child(node)
