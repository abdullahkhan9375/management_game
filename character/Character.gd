extends BaseCharacter 

class_name Character

var state: CharacterStateManager
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

func set_clock(clock: Clock):
	task_manager = TaskManager.new(clock)
	scheduler = Scheduler.new(clock, {6: "Sleep", 12: "Work", 14: "Sleep"})

func do_task():
	var interactable = Interactable.find_interactable(get_tree(), current_task.type)	
	if (interactable == null):
		print("could not find interactable for task type %s", [current_task.type])
		return
	print("starting task: %", [current_task.type])
	state.on_busy(interactable.position)

func get_task():
	return current_task

func task_control(task: Task):
	var status = task.state
	if (status == Task.TASK_STATE.COMPLETED):
		task_manager.remove_task(task.type, task.task_name)
		current_task = null
		state.on_idle()
	
func _process(delta):
	var block = scheduler.get_block()
	current_task = task_manager.current_task(block)
	if (current_task == null): return
	if (prev_block != block or current_task.task_name != active_task.task_name):
		print("new work block: %", [block])
		do_task()
		prev_block = block
		active_task = current_task