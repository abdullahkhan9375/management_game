class_name Replenishable

var data: Dictionary

func _init(Type, Value, Max_value, Rep_name = ""):

	data = {
		"task_type": Type,
		"value": Value,
		"max_value": Max_value,
		"name": Rep_name 
	}

func set_rep_name(r_name):
	data["name"] = r_name

func get_work_units():
	return data["value"]

func get_rep_name():
	return data["name"]

func get_max_value():
	return data["max_value"]

func get_task_type():
	return data["task_type"]

func replenish(amount: float):
	var val = data["value"]
	var max_val = data["max_value"]
	if (val < max_val):
		val += amount
	else:
		val = max_val
	data["value"] = val

func register_signal(task: Task):
	task.connect("replenish", replenish)
