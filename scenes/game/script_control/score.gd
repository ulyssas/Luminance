extends Panel

@export var score_value: float = 0.0:
    set(value):
        score_value = value
        update_score()

func _ready():
    $progress_bar.scale.x = 0
    $score_value.text = "0"

func update_score():
    var progress: float = score_value / 999999.0
    $progress_bar.scale.x = clamp(progress, 0.0, 1.0)
    $score_value.text = str(int(score_value))
