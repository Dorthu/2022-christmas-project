extends Node
class_name Trigger

func clicked(_target: Node2D, _event):
	push_warning("Base Trigger type received clicked event!")

func hover(_active: bool):
	push_warning("Base Trigger type received hover event!")
