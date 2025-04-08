extends Node

const SelectState = preload("res://scenes/select/select_state.gd")

var current_state = SelectState.State.SELECT_TRACKS
var music_datas: Array[MusicData]
var music_index: int = 0
var level_index: int = 0

func set_music_datas(data: Array[MusicData]):
    music_datas = data

func _ready():
    if music_datas:
        $Control/MusicSelect.music_datas = music_datas
        update_music_info()

func _on_selector_index_changed():
    if music_datas:
        update_music_info()

func update_music_info():
    music_index = $Control/MusicSelect.current_index
    if music_index < 0 or music_index >= music_datas.size():
        push_warning("無効なインデックスです")
        return

    var music: MusicData = music_datas[music_index]

    $Control.music_name = music.title
    $Control.composer =  music.composer
    $Control.note_designer =  music.note_designer

    var level_values: Dictionary = {}
    for level in music.levels:
        level_values[level.level_name] = level.level_value

    $Control/LevelSelect/Container.easy_value = level_values.get("easy", "")
    $Control/LevelSelect/Container.medium_value = level_values.get("medium", "")
    $Control/LevelSelect/Container.hard_value = level_values.get("hard", "")
    $Control/LevelSelect/Container.kuso_value = level_values.get("kuso", "")

func update_state():
    $Control.set_state(current_state)

func _unhandled_input(event):
    if event.is_action_pressed("confirm"):
        match current_state:
            SelectState.State.OPTIONS:
                pass
            SelectState.State.SELECT_TRACKS:
                current_state = SelectState.State.SELECT_LEVELS
        update_state()

    elif event.is_action_pressed("lane_1"):
        match current_state:
            SelectState.State.OPTIONS:
                current_state = SelectState.State.SELECT_LEVELS
            SelectState.State.SELECT_LEVELS:
                current_state = SelectState.State.SELECT_TRACKS
        update_state()

    elif event.is_action_pressed("lane_4"):
        match current_state:
            SelectState.State.OPTIONS:
                pass
            SelectState.State.SELECT_LEVELS:
                current_state = SelectState.State.OPTIONS
        update_state()
