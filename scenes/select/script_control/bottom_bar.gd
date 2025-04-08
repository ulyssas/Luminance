extends Control


var is_music_select: bool = false:
    set(value):
        is_music_select = value
        $cancel.visible = !value

var is_level_select: bool = false:
    set(value):
        is_level_select = value
        $options.visible = value

func _ready():
    $options.visible = false
    $cancel.visible = false
