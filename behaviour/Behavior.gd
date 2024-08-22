extends Replenishable

class_name DecayableBehavior

var decay_rate: float = 0.1  # Rate at which the behavior decays
var threshold: float = 30.0
# Called when the node enters the scene tree for the first time.

signal threshold_breached(behavior)

func _on_tick():
	data['value'] -= decay_rate
	if data["value"] < 0:
		data["value"] = 0
	check_threshold()

func check_threshold():
	if data["value"] <= threshold:
		emit_signal("threshold_breached", self)

func get_work_units():
	return data["max_value"] - data["value"]