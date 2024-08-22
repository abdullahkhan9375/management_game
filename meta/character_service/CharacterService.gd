extends Node

class_name CharacterService
var character_scn = preload("res://character/character.tscn")
var clock: Clock
var characters: Array[Character]

func _init():
	pass

func _ready():
	clock = get_parent().get_node("Clock")

func create_character():
	var instance: Character = character_scn.instantiate()
	instance.set_clock(clock)
	instance.position = Vector2(274, 376)
	characters.append(instance)
	self.add_child(instance)

func get_characters():
	return characters
