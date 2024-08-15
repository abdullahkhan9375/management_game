extends Interactable

class_name Bed

func _init():
	add_to_group("Sleep")
	is_free = true;

func _ready():
	self.connect("area_entered", _on_area_entered)

func _on_area_entered(character):
	print("character entered")

