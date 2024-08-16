extends Node2D

class_name BaseCharacter

var BASE_MOVE_SPEED = 250
var BASE_PRODUCTIVITY= 25

var move_speed: int
var cname: String
var productivity: int

func _init(c_name: String):
    move_speed = BASE_MOVE_SPEED
    self.cname = c_name
    self.productivity = BASE_PRODUCTIVITY

func get_productivity():
    return productivity;
