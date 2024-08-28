class_name Task
extends Workable

var priority: int
var max_priority: int 
var type: String
var task_name: String

func _init(work_needed, type, task_name):
	super._init(work_needed) 
	self.type = type
	self.task_name = task_name

func is_maxed():
	return self.work >= self.max_value

func set_priority(prio: int):
	self.priority = min(self.max_priority, self.priority + prio)
