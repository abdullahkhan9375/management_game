extends DecayableBehavior

class_name Sleep

func _init():
	decay_rate = 5
	threshold = randi() % 10 + 70
	super._init("Sleep", 100, randi() % 31 + 90)
