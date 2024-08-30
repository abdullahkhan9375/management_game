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
		behav.behavior_alert.connect(task_manager.on_behavior_alert)

func _on_tick(clock_time: ClockTime):
	for behav in behaviors:
		behav._on_tick();
