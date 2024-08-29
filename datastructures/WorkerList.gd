class_name WorkerList

var workers: Array

func _init():
	workers = []

func add(character: Character):
	if (has_worker(character)):
		print("worker already exists")
		return
	workers.append(character)

func remove(character: Character):
	var li = []
	for worker in workers:
		if (worker.character_name == character.character_name):
			continue
		else:
			li.append(worker)
	workers = li

func has_worker(character: Character):
	for worker in workers:
		if (worker.character_name == character.character_name):
			return true
	return false

func work(workable: Workable):
	for worker in workers:
		workable.work(worker.get_productivity())
		worker.task_control(workable.state, workable.type, workable.work_name)
