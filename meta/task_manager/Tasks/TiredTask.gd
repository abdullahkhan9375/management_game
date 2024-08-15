extends Task 

class_name TiredTask

func _init(behavior, priority):
	super._init(behavior.max_value - behavior.value, priority)
	self.behavior = behavior
	task_name = "Tired"
	type = 'Sleep'