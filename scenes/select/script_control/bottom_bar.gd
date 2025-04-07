extends Control


var is_level_select: bool = false:
    set(value):
        is_level_select = value
        $options.visible = is_level_select
        $cancel.visible = is_level_select

func _ready():
    $options.visible = false
    $cancel.visible = false

#var is_option_select: bool = false:
    #set(value):
        #is_option_select = value
