extends Node

class_name CharacterStateManager
var state;
var sprite;
var block;

func _init(Sprite: AnimatedSprite2D):
	self.sprite = Sprite
	on_idle()

func on_idle():
	state = "IDLE"
	sprite.play('idle')

func on_moving():
	state = "MOVING"
	sprite.play('moving')

func on_busy():
	state = "BUSY"
	sprite.play('idle')

func get_state():
	return state
