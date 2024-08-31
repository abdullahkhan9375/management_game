class_name Workable

enum WORK_STATE {
	INACTIVE,
	ONGOING,
	COMPLETED
}

var work_name: String
var work_units: float
var max_value: float
var type: String
var state: WORK_STATE
signal replenish(amount: float)
signal state_change(state: WORK_STATE)

func is_completed():
	return state == WORK_STATE.COMPLETED

func is_ongoing():
	return state == WORK_STATE.ONGOING

func is_inactive():
	return state == WORK_STATE.INACTIVE

func start():
	state = WORK_STATE.ONGOING
	emit_signal("state_change", state)

func _init(work_needed, type, work_name):
	self.work_name = work_name
	self.work_units = work_needed
	self.type = type
	self.state = WORK_STATE.INACTIVE
	emit_signal("state_change", state)
	self.max_value = work_needed

func work(work_units: float):
	if (self.work_units > 0):
		self.work_units -= work_units
		emit_signal("replenish", work_units)
	else:
		state = WORK_STATE.COMPLETED
		emit_signal("state_change", state)
		self.work_units = 0
	
func get_max_value():
	return self.max_value

func get_min_value():
	return 0
