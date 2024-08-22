extends Node

class_name TaskFactory

static func CreateTiredTask(rep, priority):
	return TiredTask.new(rep, priority)

static func CreateProject(rep, priority):
	return WorkTask.new(rep, 1)

static func Create(rep: Replenishable):
	if (rep.get_type() == 'Sleep'):
		return CreateTiredTask(rep, 1)
	elif (rep.get_type() == "Work"):
		return CreateProject(rep, 1)

	assert(true, "replenishable not recognized")
