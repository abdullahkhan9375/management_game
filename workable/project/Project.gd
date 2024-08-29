class_name Project
extends Workable

var workers: WorkerList = WorkerList.new()

func _init(work_needed, type, work_name):
	super._init(work_needed, type, work_name)

func on_start(character: Character):
	super.start()
	workers.add(character)	
	character.task_control(state, type, work_name)

func has_worker(character: Character):
	return workers.has_worker(character)

func on_work():
	workers.work(self)

func on_end(character: Character):
	character.task_control(state, type, work_name)
	workers.remove(character)
