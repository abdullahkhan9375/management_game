extends Task 

class_name Project

func _init(rep: Replenishable, priority):
	super._init(rep.get_work_units(), rep.get_max_value(), priority)
	task_name = rep.get_rep_name() 
	type = 'Work'
