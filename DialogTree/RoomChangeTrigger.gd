extends Trigger
class_name RoomChangeTrigger, "res://DialogTree/change-room-trigger.svg"

export var roomTarget: String

func fire(_data: Trigger.TriggerFireData):
	GameController.currentLevel.change_room(roomTarget)

