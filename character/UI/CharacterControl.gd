class_name CharacterControl

var task_progress_bar: ProgressBar
var ctrl: Control = null
var character: Character;

func _init(ctrl: Control, character: Character):
	self.ctrl = ctrl
	ctrl.get_node("ProgressBar").visible = false 
	self.character = character

# one task at a time.
func set_task_progress_bar(task: Workable):
	task_progress_bar = self.ctrl.get_node("ProgressBar")
	task_progress_bar.max_value = task.max_value
	task_progress_bar.min_value = 0
	task_progress_bar.visible = false

func on_task_update(task: Workable):
	if (task_progress_bar == null):
		return
	if (task == null or task.is_completed()):
		task_progress_bar.visible = false
	elif (task.is_ongoing() and task.has_worker(character)):
		task_progress_bar.visible = true
		task_progress_bar.set_value_no_signal((task.get_max_value() - task.work_units))
