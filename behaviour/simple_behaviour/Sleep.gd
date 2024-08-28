extends DecayableBehavior

class_name Sleep

var segments_spread = {
	"Green": 7, # green
	"Yellow": 3, # yellow
	"Red": 1, # red
}

func _init():
	super._init("Sleep", segments_spread)

