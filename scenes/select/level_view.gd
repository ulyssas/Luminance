extends VBoxContainer

@export var level_name: String = "":
    set(value):
        level_name = value
        update_score()

@export var level_value: String = "-":
    set(value):
        if value != "":
            level_value = value
            update_score()
        else:
            level_value = "-"
            update_score()

func update_score():
    $level_name.text = level_name
    $level_value.text = level_value
