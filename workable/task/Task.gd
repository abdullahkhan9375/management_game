class_name Task
extends Workable

var priority: int
var max_priority: int 
var character: Character = null

func _init(work_needed, type, task_name):
	super._init(work_needed, type, task_name) 

func is_maxed():
	return self.work_units >= self.get_max_value()

func on_start(character: Character):
	self.character = character
	super.start()
	self.character.task_control(state, type, work_name)

func has_worker(character: Character):
	if (self.character == null):
		return false
	return character.character_name == self.character.character_name

func on_work():
	super.work(character.get_productivity())
	self.character.task_control(state, type, work_name)

func on_end(character: Character):
	self.character.task_control(state, type, work_name)
	self.character = null

func set_priority(prio: int):
	self.priority = min(self.max_priority, self.priority + prio)
