extends VBoxContainer

class_name DialogController

var clickable: Clickable
var dialog = preload("res://Dialog/DialogBox.tscn")

func _ready():
	connect("gui_input", self, "_on_click")

func show_text(text: String):
	# temporary function to show a text box
	var new_box = dialog.instance()
	new_box.text = text
	$MarginContainer/CenterContainer.add_child(new_box)

func _on_click(_viewport, event, _handled):
	print("DialogController on click!")
