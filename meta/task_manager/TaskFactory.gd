extends Node

class_name TaskFactory

static func CreateTiredTask(behavior, priority):
	return TiredTask.new(behavior, priority)

static func Create(behavior: Behavior):
	var behavior_name = behavior.behavior_name

	if (behavior_name == 'Sleep'):
		return CreateTiredTask(behavior, 1)
	assert(true, "behavior not recognized")