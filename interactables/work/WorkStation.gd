extends Interactable 

class_name WorkStation

func _ready():
	self.add_to_group("Work")
	get_parent().get_node("Clock").connect('tick', _on_tick)

func _on_tick(hour):
	super._on_tick(hour)
