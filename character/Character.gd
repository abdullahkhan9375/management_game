extends BaseCharacter 

class_name Character

var state: CharacterStateManager
var ctrl: CharacterControl
var current_task: Workable
var movable: Movable
var task_manager: TaskManager
var scheduler: Scheduler
var prev_block: String
var active_task: Workable 

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
		return
	print("starting task: %", [current_task.type])
	state.on_busy(interactable.position)

func get_work():
	return current_task

func should_find_work(block):
	return prev_block != block or current_task.work_name != active_task.work_name or state.get_state() == "IDLE"

func task_control(work_state: Workable.WORK_STATE, type: String, task_name: String):
	if (work_state == Workable.WORK_STATE.COMPLETED):
		current_task = null
		state.on_idle()
	
func _process(delta):
	ctrl.on_task_update(active_task)
	var block = scheduler.get_block()
	current_task = task_manager.current_task(block)
	if (current_task == null):
		return
	if (should_find_work(block)):
		do_task()
		prev_block = block
		active_task = current_task
		ctrl.set_task_progress_bar(active_task)


func _on_tick(hour: int):
	if (task_manager): task_manager.print_tasks()
	print("current block %", [scheduler.get_block()])