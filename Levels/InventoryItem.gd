extends Control

class_name InventoryItem

export var texture: Texture

func _ready():
	$TextureRect.texture = texture
