extends Node2D


class_name Movable

var state;

func _init(state):
	self.state = state

func move_to(node_to_move: Node2D, target_node: Node2D, move_speed: float, delta):
	state.on_moving();
	var direction = (target_node.position - node_to_move.position).normalized()
	var distance = node_to_move.position.distance_to(target_node.position)
	if distance > 1:
		position += direction * move_speed * delta
		state.on_idle()