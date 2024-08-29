extends Node

class_name CharacterStateManager
var state;
var sprite;
var block;
var movable: Movable
var IDLE_POSITION = Vector2(274, 376)

func _init(Sprite: AnimatedSprite2D, mvable: Movable):
	self.sprite = Sprite
	self.movable =  mvable	
	on_idle()

func on_idle():
	state = "IDLE"
	sprite.play('idle')
	movable.move_to(IDLE_POSITION)

func on_moving():
	state = "MOVING"
	sprite.play('moving')

func on_busy(position = null):
	state = "BUSY"
	sprite.play('idle')
	if (position != null):
		on_moving()
		movable.move_to(position)
		
func get_state():
	return state
