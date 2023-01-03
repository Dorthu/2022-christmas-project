extends Trigger
class_name QuestAdvancementTrigger

export var questName: String
export var toStage: int

func fire(_data: Trigger.TriggerFireData) -> bool:
	GameController.currentLevel.set_quest(questName, toStage)
	return false
