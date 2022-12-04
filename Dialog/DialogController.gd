extends MarginContainer

class_name DialogController

var clickable: Clickable
var dialog = preload("res://Dialog/DialogBox.tscn")

func show_text(text: String):
	# temporary function to show a text box
	var new_box = dialog.instance()
	new_box.text = text
	$DialogContainer.add_child(new_box)
	print("Added dialog to container")

func _on_ClickCheck_pressed():
	print("Advancing dialog")
	get_parent().remove_child(self)


func _on_ClickCheck_button_down():
	print("Advancing dialog 2")
	get_parent().remove_child(self)
