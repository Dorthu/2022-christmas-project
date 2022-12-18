extends Node2D

class_name Level

onready var curRoom = $RoomHolder.get_child(0)

func get_room_width():
	return curRoom.width
