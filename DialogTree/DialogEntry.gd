# a dialog entry is pairing of text and dialog box style
extends Node

class_name DialogEntry, "res://DialogTree/event_handler.svg"

export(String, MULTILINE) var text: String
export(String, "Normal") var boxStyle: String = "Normal"
export var timeCost: float = 1.0
