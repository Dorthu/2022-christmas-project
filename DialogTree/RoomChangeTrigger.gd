extends Trigger
class_name RoomChangeTrigger

export var roomTarget: String

func clicked(_target: Node2D, _event):
	GameController.currentLevel.change_room(roomTarget)

