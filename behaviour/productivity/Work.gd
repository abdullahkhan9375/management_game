extends Interactable 


# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("Work")
	self.connect("area_entered", on_interaction_start)
	self.connect("area_exited", on_interaction_end) 

func _process(delta):
	pass
