extends MarginContainer

class_name DialogController

var clickable: Clickable
var dialog = preload("res://Dialog/DialogBox.tscn")
var cur_box = null

func show_text(text: String):
	# temporary function to show a text box
	cur_box = dialog.instance()
	cur_box.init(text)
	$DialogContainer.add_child(cur_box)
	print("Added dialog to container")


func _on_ClickCheck_button_down():
	if cur_box.finished():
		dismiss()
	else:
		cur_box.show_all()

func dismiss():
	DialogSystem.dialog_finished()
	get_parent().remove_child(self)
