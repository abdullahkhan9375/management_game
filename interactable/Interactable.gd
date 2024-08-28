class_name Interactable

var task: Task
var work_state: Workable.WORK_STATE
var is_free: bool = true
var character: Character = null

func on_interaction_start(character: Character):
	self.character = character
	task = character.get_task()
	if (task == null): return
	task.register_worker(character)
	is_free = false

func _on_tick(hour):
	if (task == null or character == null): return
	print("work left %", [task.work])
	task.on_work(character.get_productivity());
	character.task_control(work_state, task.type, task.task_name)
	if (task.is_completed()):
		on_interaction_end(character)

func on_interaction_end(character: Character):
	if (task == null or character == null): return
	if (self.character.character_name != character.character_name):
		return
	task.end(character)
	character.task_control(task.WORK_STATE, task.type, task.task_name)
	is_free = true
	task = null

func set_occupied():
	is_free = false

static func find_interactable(tree, type):
	var nodes = tree.get_nodes_in_group("Interactable")
	for node in nodes:
		if (node.is_in_group(type) and node.is_free):
			node.set_occupied()
			return node
	return null
