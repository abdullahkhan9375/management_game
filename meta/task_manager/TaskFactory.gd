extends Node

class_name TaskFactory

static func CreateTiredTask(rep, priority):
	return Rest.new(rep, priority)

static func CreateProject(rep, priority):
	return Project.new(rep, priority)

static func Create(rep: Replenishable):
	if (rep.get_task_type() == 'Sleep'):
		return CreateTiredTask(rep, 1)

	elif (rep.get_task_type() == "Work"):
		return CreateProject(rep, 1)

	assert(true, "replenishable not recognized")
