extends Interactable

class_name Bed
var character: Character

func _init():
	add_to_group("Sleep")
	is_free = true;
	character = null;

func _ready():
	self.connect("area_entered", _on_area_entered)
	self.connect("area_exited", _on_area_exited)

func _on_area_entered(character):
	print("%s entered", [character.cname])
	self.character = character 
	self.on_interaction_start(character) 

func _on_tick():
	var status = self._on_work()
	if (character != null):
		character.task_update(status)



func _on_area_exited(character):
	print("%s left", [character.cname])
	self.on_interaction_end()
	self.character = null
