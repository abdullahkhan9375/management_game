extends Node

class_name TaskManager

var tasks: Array[Workable] 
var intent_manager: IntentManager

func _init(clock):
	intent_manager = IntentManager.new(self)
	clock.connect("tick", _on_tick)
	tasks = []

func sorter(t1: Workable, t2: Workable):
	return t1.priority >= t2.priority

# TODO: update with other tasks.
func update_task(dec: DecayableBehavior):
	var task_type = dec.get_task_type()


func substract_sets(prio_map: Dictionary, task_names: Dictionary):
	var result = {}
	for key in prio_map.keys():
		if not task_names.has(key):
			result[key] = prio_map[key]
	return result

func task_names_for_type(type: String):
	var s = {}
	for task in tasks:
		if (task.type == type):
			s[task.task_name] = true
	return s

# create task if we get a behavior alert.
func on_behavior_alert(type, alert_level, work_needed, register_signal):
	if (tasks_exist_for_type(type)):
		# update_task(dec)
		return
	var task = TaskFactory.CreateTask(type, alert_level, work_needed)
	if (register_signal.is_valid()):
		register_signal.call(task)
	print("Task added % with work %", [task.type, task.work])
	
func tasks_exist_for_type(type):
	for task in tasks:
		if (task.type == type):
			return len(tasks[type]) > 0
	return false

func add_task(aTask):
	var tasks_for_type = tasks[aTask.type]
	for task in tasks_for_type:
		if (task.task_name == aTask.task_name):
			print("task already exits %", [task.task_name])
			return
	tasks_for_type.append(aTask)
	tasks[aTask.type] = tasks_for_type

func current_task(block):
	for task in tasks:
		if (task.type == block):
			return task
	return null

func print_tasks():
	for task in tasks:
		print("%, %, %, %", [task.type, task.work, task.priority])

func remove_task(task_type, task_name):
	var filtered_li = []
	var task_for_type = tasks[task_type]
	for task in task_for_type:
		if (task.task_name == task_name):
			continue
		filtered_li.append(task)
	tasks[task_type] = filtered_li

func _on_tick(hour: int):
	intent_manager._on_tick(hour)
