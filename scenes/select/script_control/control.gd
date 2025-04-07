extends Control

@export var music_name: String = "unknown music":
    set(value):
        music_name = value
        $MusicInfo.music_name = value

@export var composer: String = "unknown composer":
    set(value):
        composer = value
        $MusicInfo.composer = value

@export var note_designer: String = "unknown notedesigner":
    set(value):
        note_designer = value
        $MusicInfo.note_designer = value

@export var is_selected: bool = false:
    set(value):
        is_selected = value
        $selector.disabled = is_selected
        $MusicInfo.is_selected = is_selected
        $fade.is_selected = is_selected
        $BottomBar.is_level_select = is_selected

func _unhandled_input(event):
    if event.is_action_pressed("confirm"):
        if !is_selected:
            is_selected = true

    elif event.is_action_pressed("lane_1"):
        if is_selected:
            is_selected = false

    #elif event.is_action_released("lane_4"):
