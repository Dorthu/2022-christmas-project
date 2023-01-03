extends ChainTrigger
class_name QuestDependentTrigger

export var questName: String
export var requiredMin: int = -1
export var requiredMax: int = -1

func _ready():
	# hack required max to be really high if it wasn't set
	if requiredMax < 0:
		requiredMax = 9999

func fire(data: Trigger.TriggerFireData) -> bool:
	var questStatus: int = GameController.currentLevel.get_quest_status(questName)
	if questStatus >= requiredMin and questStatus <= requiredMax:
		.fire(data)
		yield(self, "trigger_finished")
	emit_signal("trigger_finished")
	return false
