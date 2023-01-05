extends Control
signal exit_overlay
class_name OverlayGuard


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().set_input_as_handled()
		emit_signal("exit_overlay", event)


func _on_TextureButton_pressed():
	emit_signal("exit_overlay")
