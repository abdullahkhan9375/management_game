extends Node

var character_service: CharacterService
var clock: Clock
# Called when the node enters the scene tree for the first time.
func _ready():
	clock = $Clock
	character_service = $CharacterService
	var names = ["Toby", "Bob", "Mike"]
	for i in names:
		character_service.create_character(i)
	var proj = $ProjectManager
	proj.assign_to_all()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
