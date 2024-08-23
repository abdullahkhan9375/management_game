extends Node2D

class_name Interactable

var task: Task
var task_state: Task.TASK_STATE
var is_free: bool = true
var character: Character = null

func _ready():
	add_to_group("Interactable")
	
func on_interaction_start(character: Character):
	self.character = character
	task = character.get_task()
	if (task == null): return
	is_free = false

func _on_tick(hour):
	if (task == null or character == null): return
	task.on_work(character.get_productivity());
	character.task_control(task)
	print("work left %", [task.work])
	if (task.is_completed()):
		on_interaction_end(character)

func on_interaction_end(character: Character):
	if (task == null or character == null): return
	task.end()
	character.task_control(task)
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
