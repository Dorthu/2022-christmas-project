extends Control


func _on_LeftBar_gui_input(event):
	print("Left bar GUI input")
	print(event)


func _on_RightBar_gui_input(event):
	print("Right bar GUI input")
	print(event)


func _on_RightBar_mouse_entered():
	print("Right bar mouse entered")
