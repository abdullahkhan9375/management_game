extends Node

class_name TaskManager

var tasks: Array 
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
	print("behavior alert: %, %", [type, alert_level])
	var task = TaskFactory.Create(type, alert_level, work_needed)
	if (register_signal.is_valid()):
		register_signal.call(task)
	add_task(task)
	print("Task added % with work %", [task.type, task.work_units])
	 
func tasks_exist_for_type(type):
	for task in tasks:
		if (task.type == type):
			return true
	return false

func add_task(aTask):
	if (tasks.size() == 0):
		tasks.append(aTask)
		return
	for task in tasks:
		if (task.work_name == aTask.work_name):
			print("task already exits %", [task.work_name])
			return
	tasks.append(aTask)

func current_task(block):
	for task in tasks:
		if (task.type == block and !task.is_completed()):
				return task
	return null

func print_tasks():
	for task in tasks:
		print("%, %", [task.type, task.work_name, task.work_units])

func garbage_collect():
	var fil = []
	for task in tasks:
		if (task.is_completed()):
			continue
			print("gc'ed %", [task.work_name])
		else:
			fil.append(task)
	tasks = fil		

func _on_tick(clock_time: ClockTime):
	intent_manager._on_tick(clock_time)
	garbage_collect()
