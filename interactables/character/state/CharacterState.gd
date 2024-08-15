extends Node

class_name CharacterStateManager
var state;
var sprite;

# Called when the node enters the scene tree for the first time.
func _init(Sprite: AnimatedSprite2D):
    self.sprite = Sprite

func on_idle():
    state = "IDLE"
    sprite.play('idle')

func on_moving():
    state = "MOVING"
    sprite.play('moving')

func get_state():
    return state
