extends Node2D
class_name Movable

var target_position = null
var can_move = false
var move_speed: int
var character: Character

signal on_moving_start()
signal on_moving_stop(is_idle: bool)

func _ready():
	self.character = get_parent()
	self.move_speed = get_parent().move_speed

func _move_to(delta):
	if target_position.x < self.character.position.x:
		character.scale.x = -abs(character.scale.x)  # Flip the character to face left
	elif target_position.x > character.position.x:
		character.scale.x = abs(character.scale.x)
	var direction = character.position.move_toward(target_position, delta * self.move_speed)
	character.position = direction

func _move_to_target_position(delta):
	if (character.position.distance_to(target_position) >= 1):
		_move_to(delta)
	else:
		character.position = target_position
		can_move = false
		emit_signal("on_moving_stop", character.current_task == null)

func set_move_speed(move_speed):
	self.move_speed = move_speed

func move_to(target_position):
	self.target_position = target_position
	can_move = true
	emit_signal("on_moving_start")

func has_reached():
	return self.char_position == target_position

func _process(delta):
	if (target_position == null):
		return

	if (can_move):
		_move_to_target_position(delta)