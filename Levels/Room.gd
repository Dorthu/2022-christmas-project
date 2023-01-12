extends Node2D
signal toggleClickables
class_name LevelRoom

onready var width = $Background.texture.get_width()

# set_interactable is used when overlays are shown to enable/disable all clickables
# in the room; this allows overlays to be shown over top of the room without having
# click events trigger clickables underneath
func set_interactable(interactable: bool):
	emit_signal("toggleClickables", interactable)
