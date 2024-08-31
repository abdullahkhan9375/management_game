extends Node

class_name CharacterStateManager
var state;
var sprite;
var block;
var movable: Movable
var IDLE_POSITION = Vector2(274, 376)

enum CHARACTER_STATE {
	MOVING_START,
	MOVING_STOP,
	IDLE,
	BUSY
}

func _init(Sprite: AnimatedSprite2D):
	self.sprite = Sprite
	on_idle()

func on_idle():
	state = "IDLE"
	sprite.play('idle')

func on_moving_start():
	state = "MOVING"
	sprite.play('moving')

func on_moving_stop(is_idle: bool):
	if (is_idle):
		on_idle()
	else:
		on_busy()

func on_busy():
	state = "BUSY"
	sprite.play('idle')
		
func change_handler(state_change: CHARACTER_STATE):
	if (state_change == CHARACTER_STATE.BUSY):
		on_busy()
	elif (state_change == CHARACTER_STATE.MOVING_START):
		on_moving_start()
	elif (state_change == CHARACTER_STATE.MOVING_STOP):
		# fix me
		on_moving_stop(true)
	else:
		on_idle()

func get_state():
	return state
