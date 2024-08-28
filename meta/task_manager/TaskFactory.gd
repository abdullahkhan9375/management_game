class_name TaskFactory

static func CreateRestTask(work_needed):
	return Task.new(work_needed, "Sleep", "Rest")

static func CreateDozeOffTask(work_needed):
	return Task.new(work_needed, "Sleep", "DozeOff")

static func CreateFaintTask(work_needed):
	return Task.new(work_needed, "Sleep", "Faint")

static func CreateSleepTask(alert_level, work_needed):
	if alert_level == "Green":
		return CreateRestTask(work_needed)
	elif alert_level == "Yellow":
		return CreateDozeOffTask(work_needed)
	elif alert_level == "Red":
		return CreateFaintTask(work_needed)
	return null

static func CreateTask(type, alert_level, work_needed):
	if (type == 'Sleep'):
		return CreateSleepTask(alert_level, work_needed)	
	else:
		print("behavior not recognized")
