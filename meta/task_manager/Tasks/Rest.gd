extends Task 

class_name Rest

func _init(rep, priority):
	super._init(rep.get_work_units(), rep.get_max_value(), priority)
	task_name = "Rest"
	type = rep.get_task_type()
