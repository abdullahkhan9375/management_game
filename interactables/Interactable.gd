extends Node

class_name Interactable

var task: Task
var work_productivity: int
var is_free: bool

func _init():
	add_to_group("Interactable")

func on_interaction_start(character: Character):
	work_productivity = character.get_productivity()
	task = character.get_task()
	print("task registered: %s", [task.task_name])
	is_free = false

func _on_work():
	if (task == null):
		return -1
	if (task.is_completed()):
		print("task completed")
		on_interaction_end()
		return 1
	print("working on task with %s prod", [work_productivity])
	task.on_work(work_productivity);
	return 0

func on_interaction_end():
	if (task != null):
		task.end()
	work_productivity = 0;
	is_free = true
	task = null

static func find_interactable(tree, task_type):
	var nodes = tree.get_nodes_in_group("Interactable")
	for node in nodes:
		if (node.is_in_group(task_type) and node.is_free):
			return node
	return null
