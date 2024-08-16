extends Node

class_name Interactable

var task: Task
var work_productivity: int
var is_free: bool = true
var character: Character

func _init():
	character = null
	add_to_group("Interactable")

func on_interaction_start(character: Character):
	self.character = character
	work_productivity = character.get_productivity()
	task = character.get_task()
	print("task registered: %s", [task.task_name])
	is_free = false

func _on_tick():
	if (task == null or character == null): return
	task.on_work(work_productivity);
	character.task_control(Task.TASK_STATE.ONGOING)
	
	if (task.is_completed()):
		on_interaction_end()
		character.task_control(Task.TASK_STATE.COMPLETED)
		return

func on_interaction_end():
	if (task != null):
		task.end()
		task = null
	work_productivity = 0;
	is_free = true
	print("task completed")

static func find_interactable(tree, task_type):
	var nodes = tree.get_nodes_in_group("Interactable")
	for node in nodes:
		if (node.is_in_group(task_type) and node.is_free):
			return node
	return null
