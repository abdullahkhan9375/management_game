class_name Scheduler

var schedule: Dictionary
var schedule_keys: Array
var block: String

func _init(clock: Clock, schedule: Dictionary):
	self.schedule = schedule
	schedule_keys = schedule.keys()
	schedule_keys.sort()
	clock.connect("tick", update)

func update(hour: int):
	var keys = schedule_keys 
	if (block == ""):
		block = schedule[keys[0]]
		return

	for idx in range(len(keys) - 1):
		var i = keys[idx]
		var j = keys[idx + 1]
		if (hour >= i and hour < j):
			block = schedule[i]
			break		
		elif (hour >= keys[-1]):
			block = schedule[keys[-1]]
			break

func get_block():
	return self.block

func is_in_schedule(type: String):
	return type == block