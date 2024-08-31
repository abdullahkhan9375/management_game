extends Node
class_name Scheduler

var schedule: Dictionary
var schedule_keys: Array

var block: String
var prev_block: String

var current_task: Workable
var active_task: Workable

var task_manager: TaskManager
var state: CharacterStateManager

signal on_state_change(state: CharacterStateManager.CHARACTER_STATE)
signal move(position)
signal work_update(work: Workable)

func _init(clock: Clock, schedule: Dictionary, state: CharacterStateManager):
	self.task_manager = TaskManager.new(clock)
	self.schedule = schedule
	self.state = state
	schedule_keys = schedule.keys()
	schedule_keys.sort()
	clock.connect("tick", on_tick)

func update_block(hour: int):
	var keys = schedule_keys 
	if (block == ""):
		block = schedule[keys[0]]
		return
	for idx in range(len(keys) - 1):
		var i = keys[idx]
		var j = keys[idx + 1]
		if (hour >= i and hour < j):
			block = schedule[i]
			break		
		elif (hour >= keys[-1]):
			block = schedule[keys[-1]]
			break

func work_state_handler(work_state: Workable.WORK_STATE):
	if (work_state == Workable.WORK_STATE.COMPLETED):
		current_task = null
		emit_signal("on_state_change", CharacterStateManager.CHARACTER_STATE.IDLE)

func should_find_work(block):
	return prev_block != block or current_task.work_name != active_task.work_name or state.get_state() == "IDLE"

func do_task():
	var interactable = Interactable.find_interactable(get_tree(), current_task.type)	
	if (interactable == null):
		return
	emit_signal("move", interactable.position)
	state.on_busy()

func on_tick(clock_time: ClockTime):
	update_block(clock_time.get_hour())

func _process(delta):
	emit_signal("task_update", active_task)
	current_task = task_manager.current_task(block)
	if (current_task == null):
		return
	if (should_find_work(block)):
		do_task()
		prev_block = block
		active_task = current_task

func get_block():
	return self.block

func is_in_schedule(type: String):
	return type == block