extends BaseCharacter 

class_name Character

var state: CharacterStateManager
var ctrl: CharacterControl
var current_task: Task
var movable: Movable
var task_manager: TaskManager
var scheduler: Scheduler
var prev_block: String
var active_task: Task

func _init():
	super._init()
	
func _ready():
	state = CharacterStateManager.new($AnimatedSprite2D, $Movable);
	ctrl = CharacterControl.new($Control, self)

func set_clock(clock: Clock):
	task_manager = TaskManager.new(clock)
	scheduler = Scheduler.new(clock, {2: "Work", 6: "Sleep"})
	clock.connect("tick", _on_tick)

func set_character_name(c_name: String):
	self.character_name = c_name

func do_task():
	var interactable = Interactable.find_interactable(get_tree(), current_task.type)	
	if (interactable == null):
		print("could not find interactable for task type %s", [current_task.type])
		return
	print("starting task: %", [current_task.type])
	state.on_busy(interactable.position)

func get_task():
	return current_task

func task_control(work_state: Workable.WORK_STATE, type: String, task_name: String):
	if (work_state == Workable.WORK_STATE.COMPLETED):
		task_manager.remove_task(type, task_name)
		current_task = null
		state.on_idle()
	
func _process(delta):
	ctrl.on_task_update(active_task)
	var block = scheduler.get_block()
	current_task = task_manager.current_task(block)
	if (current_task == null): return
	if (prev_block != block or current_task.task_name != active_task.task_name):
		print("new work block: %", [block])
		do_task()
		prev_block = block
		active_task = current_task
		ctrl.set_task_progress_bar(active_task)


func _on_tick(hour: int):
	if (task_manager): task_manager.print_tasks()
	print("current block %", [scheduler.get_block()])