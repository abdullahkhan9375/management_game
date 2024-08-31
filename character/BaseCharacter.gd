extends Node2D

class_name BaseCharacter

var BASE_MOVE_SPEED = 250
var BASE_PRODUCTIVITY= 1

var move_speed: int
var productivity: int
@export var character_name: String

func _init():
    move_speed = BASE_MOVE_SPEED
    self.productivity = BASE_PRODUCTIVITY

func get_productivity():
    return productivity;
