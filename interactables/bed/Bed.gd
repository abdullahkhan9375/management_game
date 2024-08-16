extends Interactable

class_name Bed

func _init():
	add_to_group("Sleep")

func _ready():
	self.connect("area_entered", _on_area_entered)
	self.connect("area_exited", _on_area_exited)
	get_parent().get_node("Scheduler").connect('tick', _on_tick)

func _on_area_entered(character):
	self.on_interaction_start(character) 

func _on_tick():
	super._on_tick()

func _on_area_exited(character):
	print("area exited")
	self.on_interaction_end()
