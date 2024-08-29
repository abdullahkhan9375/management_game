extends Replenishable

class_name DecayableBehavior

var max_level = 100

var decay_dict = {
	"Green": 5,
	"Yellow": 3,
	"Red": 1
}

var segments: Array
var seg_idx: int = 0
var prev_seg: Segment = null

signal behavior_alert(type, alert_level, work_needed, register_signal)

func _init(Type, task_segments: Dictionary):
	super._init(Type, max_level, max_level)
	segments = create_segments(task_segments)

func get_work_units():
	return data["max_value"] - data["value"]

func current_segment():
	return segments[seg_idx]

func _on_tick():
	var cur_segment = current_segment()
	var val = data["value"]
	val -= cur_segment.decay_rate
	if val < 0:
		val = 0
	data['value'] = val
	check_segment(cur_segment)

func get_alert_level():
	return segments[seg_idx].get_alert_level()

func check_segment(seg: Segment):
	if data["value"] <= seg.get_value():
		emit_signal("behavior_alert", self.get_task_type(), seg.get_alert_level(), seg.get_value(), self.register_signal)
		seg_idx += 1

func calc_total_prio(task_segments):
	var sum = 0
	for key in task_segments.keys():
		var seg = task_segments[key]
		sum += seg 
	return sum

func segment_sorter(s1: Segment, s2: Segment):
	return s1.get_value() > s2.get_value()
		
# green, yellow, red
func create_segments(task_segments):
	var task_seg_list = []
	var total = calc_total_prio(task_segments)
	for key in task_segments.keys():
		var seg_entry = task_segments[key]
		var max_val = (seg_entry * data["max_value"]) / total	
		# TODO
		var decay_rt = decay_dict[key]
		task_seg_list.append(Segment.new(max_val, decay_rt, key))
	task_seg_list.sort_custom(segment_sorter)
	return task_seg_list
