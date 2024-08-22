extends Task 

class_name TiredTask

func _init(behavior, priority):
	super._init(behavior.get_work_units(), priority)
	task_name = "Tired"
	type = 'Sleep'
