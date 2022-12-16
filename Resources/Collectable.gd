extends Clickable
tool
class_name Collectable

onready var spriteInstance: Sprite = $Sprite
onready var shape: RectangleShape2D = $Area2D/CollisionShape2D.shape

#: Sprite for this collectable
export var sprite: Texture

func _ready():
	spriteInstance.texture = sprite
	shape.extents = spriteInstance.get_rect().size / 2
