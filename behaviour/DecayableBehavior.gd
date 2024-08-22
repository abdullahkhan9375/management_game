extends Replenishable

class_name DecayableBehavior

var decay_rate: float = 0.1  # Rate at which the behavior decays
var threshold: float = 30.0
# Called when the node enters the scene tree for the first time.

signal threshold_breached(behavior)

func _init(Type, Value, Max_Value):
	super._init(Type, Value, Max_Value)

func _on_tick():
	value -= decay_rate
	if value < 0:
		value = 0
	check_threshold()

func check_threshold():
	if value <= threshold:
		emit_signal("threshold_breached", self)
