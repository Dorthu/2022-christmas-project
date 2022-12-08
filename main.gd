extends Node2D

class_name main

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	DialogSystem.load_tree("res://Levels/Tutorial/dialog-tree.yaml")
