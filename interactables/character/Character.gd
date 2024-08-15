extends Node2D

class_name Character

var state: CharacterStateManager;
var task_manager;
var movable: Movable
# Called when the node enters the scene tree for the first time.
func _ready():
	state = CharacterStateManager.new($AnimatedSprite2D);
	state.on_idle();
	task_manager = TaskManager.new()
	movable = Movable.new(state)

func get_producitvity():
	return 1.0;

func do_task(task: Task, delta):
	print("doing task %s", [task.task_name])
	var interactable = Interactable.find_interactable(get_tree(), task.type)	
	movable.move_to(self, interactable, 2.0, delta)

func _process(delta):
	if (state.get_state() == "IDLE"):
		do_task(task_manager.current_task(), delta)
	pass

func _on_tick():
	pass # Replace with function body.
