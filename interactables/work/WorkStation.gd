extends Interactable 

class_name WorkStation

func _ready():
	self.add_to_group("Work")
	get_parent().get_node("Clock").connect('tick', _on_tick)
	self.connect("area_entered", on_interaction_start)
	self.connect("area_exited", on_interaction_end) 
