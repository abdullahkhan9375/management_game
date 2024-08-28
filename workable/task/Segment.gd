class_name Segment

var max_value: float
var decay_rate: float
var value: float
var alert_level: String
var segment_name: String

func _init(max_value, decay_rate, alert_level):
	self.alert_level = alert_level
	self.max_value = max_value
	self.decay_rate = decay_rate
	self.value = max_value

func get_value():
	return self.value

func get_alert_level():
	return self.alert_level
