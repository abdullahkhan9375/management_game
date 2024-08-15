extends Node

class_name Interactable

var task: Task
var work_productivity: int
var is_free: bool

func _init():
	add_to_group("Interactable")

func register_task(tsk: Task):
	task = tsk

func on_interaction_start(character: Character):
	work_productivity = character.get_productivity()

func on_work():
	task.on_work(work_productivity);

func on_interaction_end():
	work_productivity = 0;

static func find_interactable(tree, task_type):
	var nodes = tree.get_nodes_in_group("Interactable")
	for node in nodes:
		if (node.is_in_group(task_type) and node.is_free):
			return node
	return null
