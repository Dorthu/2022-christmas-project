extends CenterContainer

class_name DialogBox

var content: String
var total_delta: float = 0
onready var text_box: RichTextLabel = $NinePatchRect/MarginContainer/Text

# this is how slowly/quickly characters appear in the text box, in characters/second
# a value of 1.0 means "one character per second"
const TIMING_MOD: float = 30.0

# when created, set our content up
func init(show_text: String):
	content = show_text

# when added to the scene, set the text and hide all characters
func _ready():
	text_box.text = content
	text_box.visible_characters = 0

# show more characters every frame until they're all visible
func _process(delta):
	print("Called process with delta ", total_delta)
	if not finished():
		total_delta += delta * TIMING_MOD
		text_box.visible_characters = int(round(total_delta))

func finished():
	return text_box.visible_characters >= len(content) or text_box.visible_characters == -1

func show_all():
	text_box.visible_characters = -1
