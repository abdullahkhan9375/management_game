class_name Interactable

var work: Workable
var work_state: Workable.WORK_STATE
var is_free: bool = true
var character: Character;

func on_interaction_start(character: Character):
	self.character = character
	print("interaction started: %", [character.character_name])
	is_free = false
	work = character.get_work()
	if (work == null): return
	work.on_start(character)

func _on_tick(clock_time: ClockTime):
	if (work == null): return
	work.on_work()

func on_interaction_end(character: Character):
	if (work == null or self.character.character_name != character.character_name): return
	print("interaction ended: %", [character.character_name])
	is_free = true
	work.on_end(character)
	self.character = null
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
