extends Node

class_name IntentManager

var behaviors: Array
var task_manager: TaskManager
var c_name: String

func _init(tsk_manager: TaskManager):
	self.task_manager = tsk_manager
	behaviors = []
	behaviors.append(Sleep.new())
	for behav in behaviors:
		behav.threshold_breached.connect(task_manager.register_breached_behavior)

func _on_tick(hour):
	for behav in behaviors:
		behav._on_tick();
