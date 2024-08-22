extends Node

class_name TaskManager

var task_list: Array
var c_name: String 

func _init(c_name: String):
	#TODO: remove this. only for debugging purposes.
	self.c_name = c_name
	task_list = []

func sorter(t1: Task, t2: Task):
	return t1.priority >= t2.priority

func rearrange_tasks():
	task_list.sort_custom(sorter)

func register_breached_behavior(rep: Replenishable):
	var behavior_type = rep.data['type']
	var work_needed = rep.get_work_units()
	if (!task_exists(behavior_type)):
		var task = TaskFactory.Create(rep)
		rep.register_signal(task)
		task_list.append(task)
		rearrange_tasks()
	else:
		for task in task_list:
			if (task.type == behavior_type and !task.is_ongoing()):
				task.set_priority(task.priority + 1)
				task.set_work(work_needed)
				rearrange_tasks()

func task_exists(type):
	for task in task_list:
		if (type == task.type):
			return true
	return false

func current_task():
	if (len(task_list) > 0): return task_list[0]
	return null

func print_tasks():
	for task in task_list:
		print("%, %, %, %", [self.c_name, task.task_name, task.work, task.priority])

func remove_task(task_type):
	var filtered_li = []
	for task in task_list:
		if task.type == task_type:
			continue
		filtered_li.append(task)
	self.task_list = filtered_li

