class_name Interactable

var work: Workable
var work_state: Workable.WORK_STATE
var is_free: bool = true

func on_interaction_start(character: Character):
	work = character.get_work()
	if (work == null): return
	work.on_start(character)
	is_free = false

func _on_tick(hour):
	if (work == null): return
	print("work left %", [work.work_units])
	work.on_work()

func on_interaction_end(character: Character):
	if (work == null): return
	work.on_end(character)
	is_free = true
	work = null

func set_occupied():
	is_free = false

static func find_interactable(tree, type):
	var nodes = tree.get_nodes_in_group("Interactable")
	for node in nodes:
		if (node.is_in_group(type) and node.is_free()):
			node.set_occupied()
			return node
	return null
