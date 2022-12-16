extends Node

var dialog_controller = preload("res://Dialog/DialogController.tscn")

# stateful vars
var curController: DialogController = null
var dialog_tree: Dictionary = {}
var yaml = preload("res://addons/godot-yaml/gdyaml.gdns").new()


func _ready():
	print("Dialog system exists")

func load_tree(path):
	var file = File.new()
	file.open(path, File.READ)
	var res = yaml.parse(file.get_as_text())
	if res.error_string:
		push_warning(res.error_string)
		return
	dialog_tree = res.result
	file.close()

func clicked(_viewport, event, handled, clickable):
	if not event is InputEventMouseButton or not event.pressed:
		return
	
	print("Clickable was clicked!")
		
	if handled:
		return
	
	if clickable.treeTarget.is_empty():
		push_warning(str("Clickable ", clickable, " not configured for dialog!"))
		return
	
	var target = clickable.get_node(clickable.treeTarget)
	if not target is Interactable:
		push_warning(str("Clickable ", clickable, " was not refernecing an Interactable with its Tree Target"))
		return
	
	target.handle_click(event)

func show_dialog(text):
	curController = dialog_controller.instance()
	get_tree().root.add_child(curController)
	curController.show_text(text)
