extends Node2D
class_name WorkStation

var interactable: Interactable = null

func _ready():
	interactable = Interactable.new()
	self.add_to_group("Work")
	get_parent().get_node("Clock").connect('tick', interactable._on_tick)
	self.connect("area_entered", interactable.on_interaction_start)
	self.connect("area_exited", interactable.on_interaction_end) 

func is_free():
	return interactable.is_free

func set_occupied():
	return interactable.set_occupied()