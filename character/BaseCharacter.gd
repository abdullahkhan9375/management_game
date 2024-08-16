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

func move_to(position: Vector2, delta):
    if position.x < self.position.x:
        self.scale.x = -abs(self.scale.x)  # Flip the character to face left
    elif position.x > self.position.x:
        self.scale.x = abs(self.scale.x)
    var direction = self.position.move_toward(position, move_speed * delta)
    self.position = direction
