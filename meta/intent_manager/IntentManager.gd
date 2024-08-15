extends Node

class_name IntentManager
var behaviors: Array
var task_manager: TaskManager
func _init(tsk_manager: TaskManager):
	self.task_manager = tsk_manager
	behaviors = []
	behaviors.append(SleepBehavior.new())
	for behav in behaviors:
		add_child(behav)
		behav.threshold_breached.connect(task_manager.register_breached_behavior)
	print("intent manager initialized")

func _on_tick():
	for behav in behaviors:
		behav._on_tick();

func process_breached_behaviors():
	for child in get_children():
		if child is Behavior and child.value <= child.threshold:
			print("Processing breached behavior: ", child.name)