extends Task 

class_name WorkTask 

func _init(rep: Replenishable, priority):
	super._init(rep.get_work_units(), priority)
	task_name = rep.get_rep_name() 
	type = 'Work'
