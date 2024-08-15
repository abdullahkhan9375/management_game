extends Task 

class_name TiredTask

func _init(work_needed, priority):
	super._init(work_needed, priority)
	type = 'Sleep'
