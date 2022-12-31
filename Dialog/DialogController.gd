extends MarginContainer

class_name DialogController

var clickable: Clickable
var dialog = preload("res://Dialog/DialogBox.tscn")
var cur_box = null
var cur_text = []
var cur_text_index = 0

func show_text(text: String):
	# temporary function to show a text box
	cur_box = dialog.instance()
	
	# use the box to split the text into lines
	cur_text = cur_box.break_string(text)
	cur_text_index = 0
	
	cur_box.init(cur_text[0])
	$DialogContainer.add_child(cur_box)
	print("Added dialog to container")


func _on_ClickCheck_button_down():
	if cur_box.finished():
		next()
	else:
		cur_box.show_all()

func next():
	cur_text_index += 1
	if cur_text_index >= len(cur_text):
		dismiss()
		return
	
	$DialogContainer.remove_child(cur_box)
	cur_box = dialog.instance()
	cur_box.init(cur_text[cur_text_index])
	$DialogContainer.add_child(cur_box)

func dismiss():
	DialogSystem.dialog_finished()
	get_parent().remove_child(self)
