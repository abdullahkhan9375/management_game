extends Interactable

class_name Bed

func _ready():
	self.add_to_group("Rest")
	self.connect("area_entered", on_interaction_start)
	self.connect("area_exited", on_interaction_end) 
