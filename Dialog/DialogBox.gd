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
	if not finished():
		total_delta += delta * TIMING_MOD
		text_box.visible_characters = int(round(total_delta))

func finished():
	return text_box.visible_characters >= len(content) or text_box.visible_characters == -1

func show_all():
	text_box.visible_characters = -1

# given a string, breaks it into multiple strings, each of which will fit inside this text box
func break_string(string: String) -> Array:
	var font = $NinePatchRect/MarginContainer/Text.get_font("normal_font")
	
	var final = []
	# split newlines - each newline in the original string is a next text box
	var parts = string.split("\n")
	
	for part in parts:
		# no empty text boxes
		if not part:
			continue
		
		var string_size = font.get_wordwrap_string_size(part, $NinePatchRect/MarginContainer/Text.margin_right)
		if string_size.y < $NinePatchRect/MarginContainer/Text.margin_bottom:
			final.append(part)
		else:
			# split the string into textbox-sized chunks
			final.append_array(_break_long_string(part, font))
	
	return final

# breaks a string that won't fit in one box into several strings
func _break_long_string(string: String, font: Font) -> Array:
	# iterate backwards from spaces until the left side of the string fits.  Do this repeatedly until
	# all parts fit
	var result = []
	var remaining = string
	var pos = len(remaining)
	while remaining:
		var string_size = font.get_wordwrap_string_size(remaining.left(pos), $NinePatchRect/MarginContainer/Text.margin_right)
		if string_size.y < $NinePatchRect/MarginContainer/Text.margin_bottom:
			result.append(remaining.left(pos))
			remaining = remaining.right(pos)
			pos = len(remaining)
		else:
			pos = remaining.rfind(" ", pos-1)
		
	
	return result
