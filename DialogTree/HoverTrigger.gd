extends Trigger
class_name HoverTrigger

func hover(active: bool):
	print("hover called!")
	if $toggle:
		print("toggling visibility of thing")
		$toggle.visible = active
