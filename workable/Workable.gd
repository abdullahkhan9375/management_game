class_name Workable

enum WORK_STATE {
	INACTIVE,
	ONGOING,
	COMPLETED
}

var work: float
var state: WORK_STATE
signal replenish(amount: float)

func is_completed():
	return state == WORK_STATE.COMPLETED

func is_ongoing():
	return state == WORK_STATE.ONGOING

func is_inactive():
	return state == WORK_STATE.INACTIVE

func _init(work_needed):
	self.work = work_needed
	self.state = WORK_STATE.INACTIVE

func on_work(work_units: float):
	if (self.work > 0):
		state = WORK_STATE.ONGOING
		self.work -= work_units
		emit_signal("replenish", work_units)
	else:
		state = WORK_STATE.COMPLETED
		self.work = 0
