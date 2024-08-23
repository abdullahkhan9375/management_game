extends Node

class_name TaskManager

var tasks: Dictionary 
var intent_manager: IntentManager

func _init(clock):
	intent_manager = IntentManager.new(self)
	clock.connect("tick", _on_tick)
	tasks = {
		'Sleep': [],
		'Work': [],
	}

func sorter(t1: Task, t2: Task):
	return t1.priority >= t2.priority

func rearrange_tasks(type):
	for k in tasks.keys():
		if (type == k):
			tasks[k].sort_custom(sorter)
			return

# TODO: update with other tasks.
func update_decayable_task(dec: DecayableBehavior):
	var tasks_for_type = tasks[dec.get_task_type()]
	for task in tasks_for_type:
		# skip updating on going task
		if (task.is_ongoing()):
			return
		if (task.is_maxed()):
			task.set_priority(task.priority + 2)
		else:
			task.set_priority(task.priority + 1)
			task.set_work(dec.get_work_units())
	rearrange_tasks(dec.get_task_type())

func register_breached_behavior(dec: DecayableBehavior):
	var type = dec.get_task_type()
	var work_needed = dec.get_work_units()
	if (tasks_exist_for_type(type)):
		update_decayable_task(dec)
		return
	var task = TaskFactory.Create(dec)
	dec.register_signal(task)
	tasks[type] = [task]
	rearrange_tasks(type)
	print("Task added %", [task.type])
	
func tasks_exist_for_type(type):
	for task_type in tasks.keys():
		if (type == task_type):
			return len(tasks[type]) > 0
	return false

func add_task(aTask):
	var tasks_for_type = tasks[aTask.type]
	for task in tasks_for_type:
		if (task.task_name == aTask.task_name):
			return
	tasks_for_type.append(aTask)
	tasks[aTask.type] = tasks_for_type

func current_task(block):
	if (!tasks.keys().has(block)):
		return null
	var task_list = tasks[block]	
	if (len(task_list) > 0): return task_list[0]
	return null

func print_tasks():
	for key in tasks.keys():
		var task = tasks[key]
		print("%, %, %, %", [self.c_name, task.task_name, task.work, task.priority])

func remove_task(task_type, task_name):
	var filtered_li = []
	var tasks_for_type = tasks[task_type]
	for task in tasks_for_type:
		if (task.task_name == task_name):
			continue
		filtered_li.append(task)
	tasks[task_type] = filtered_li
	return null

func _on_tick(hour: int):
	intent_manager._on_tick(hour)
