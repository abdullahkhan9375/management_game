extends Node

class_name TaskManager

var task_list: Array

func _init():
	task_list = []

func sorter(t1: Task, t2: Task):
	return t1.priority >= t2.priority

func rearrange_tasks():
	task_list.sort_custom(sorter)

func register_breached_behavior(behavior: Behavior):
	var behavior_name = behavior.behavior_name
	var work_needed = behavior.max_value - behavior.value 
	if (!task_exists(behavior)):
		var task = TaskFactory.Create(behavior)
		task_list.append(task)
		rearrange_tasks()
	else:	
		for task in task_list:
			if (task.type == behavior_name and task.is_inactive()):
				task.set_priority(task.priority + 1)
				task.set_work(work_needed)
				rearrange_tasks()
			
	
func task_exists(behavior):
	for task in task_list:
		if (behavior.behavior_name == task.type):
			return true
	return false

func current_task():
	if (len(task_list) > 0): return task_list[0]
	return null

func print_tasks():
	for task in task_list:
		print("%s, %s, %s" % [task.task_name, task.work, task.priority])

func remove_task(task_type):
	var filtered_li = []
	for task in task_list:
		if task.type == task_type:
			continue
		filtered_li.append(task)
	self.task_list = filtered_li

