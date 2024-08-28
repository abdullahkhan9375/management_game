extends Node2D

class_name Bed

var clock: Clock

func _ready():
	var interactable = Interactable.new()
	self.add_to_group("Interactable")
	self.add_to_group("Rest")
	get_parent().get_node("Clock").connect("tick", interactable._on_tick)
	self.connect("area_entered", interactable.on_interaction_start)
	self.connect("area_exited", interactable.on_interaction_end) 
