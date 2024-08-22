extends Interactable

class_name Bed

var clock: Clock

func _ready():
	self.add_to_group("Rest")
	clock = get_parent().get_node("Clock")
	clock.connect("tick", _on_tick)
	self.connect("area_entered", on_interaction_start)
	self.connect("area_exited", on_interaction_end) 
