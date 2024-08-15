extends Node

class_name Task

var task_name: String
var work: int
var priority: int
var state: TASK_STATE
var type: String

enum TASK_STATE {
	INACTIVE,
	ONGOING,
	COMPLETED
}

func _init(work_needed, priority):
	self.work = work_needed
	self.priority = priority
	self.state = TASK_STATE.INACTIVE

func on_work(work_unit):
	if (self.work >= 0):
		self.state = TASK_STATE.ONGOING
		self.work -= work_unit
	else:
		self.state = TASK_STATE.COMPLETED
	return self.work	

func set_priority(priority):
	if (priority <= 10):
		self.priority = priority
	else:
		self.priority = 10

func set_work(work):
	if (self.work <= 100):
		self.work = work
	else:
		self.work = 100