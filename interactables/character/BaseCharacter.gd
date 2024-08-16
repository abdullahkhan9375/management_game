extends Node2D

class_name BaseCharacter

var BASE_MOVE_SPEED = 2.0
var BASE_PRODUCTIVITY= 5.0

var move_speed: int
var c_name: String
var productivity: int

func _init(c_name: String):
    move_speed = BASE_MOVE_SPEED
    self.c_name = c_name
    self.productivity = BASE_PRODUCTIVITY

func get_productivity():
    return productivity;
