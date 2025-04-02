extends Panel

@export var perfect_value: float = 0.0:
    set(value):
        perfect_value = value
        $perfect_value.text = str(int(perfect_value))

@export var great_value: float  = 0.0:
    set(value):
        great_value = value
        $great_value.text = str(int(great_value))

@export var good_value: float  = 0.0:
    set(value):
        good_value = value
        $good_value.text = str(int(good_value))

@export var miss_value: float  = 0.0:
    set(value):
        miss_value = value
        $miss_value.text = str(int(miss_value))

func _ready():
    $perfect_value.text = "0"
    $great_value.text = "0"
    $good_value.text = "0"
    $miss_value.text = "0"
    
