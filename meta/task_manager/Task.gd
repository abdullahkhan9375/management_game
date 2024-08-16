extends Node

class_name Task

var task_name: String
var work: float
var priority: int
var state: TASK_STATE
var type: String
var behavior: Behavior
var original_value: float

enum TASK_STATE {
	INACTIVE,
	ONGOING,
	COMPLETED
}

func _init(work_needed, priority):
	self.work = work_needed
	self.priority = priority
	self.state = TASK_STATE.INACTIVE
	self.original_value = work_needed

func is_completed():
	return state == TASK_STATE.COMPLETED

func is_ongoing():
	return state == TASK_STATE.ONGOING

func is_inactive():
	return state == TASK_STATE.INACTIVE

func end():
	print("task ended with % %", [work, priority])
	if (self.work > 0):
		state = TASK_STATE.INACTIVE
		behavior.replenish(self.original_value - self.work)
	else:
		state = TASK_STATE.COMPLETED
		behavior.replenish_full()

func on_work(work_unit):
	if (self.work > 0):
		self.state = TASK_STATE.ONGOING
		self.work -= work_unit
	else:
		self.state = TASK_STATE.COMPLETED

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
