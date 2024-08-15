extends Node

class_name TaskFactory

static func CreateTiredTask(work_needed, priority):
	return TiredTask.new(work_needed, priority)

static func Create(behavior, work_needed):
	if (behavior == 'Sleep'):
		return CreateTiredTask(work_needed, 1)