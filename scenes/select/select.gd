extends Node

var music_datas: Array[MusicData]
var music_index: int = 0

func set_music_datas(data: Array[MusicData]):
    music_datas = data

func _ready():
    if music_datas:
        $Control/selector.music_datas = music_datas
        update_view()

func _on_selector_index_changed():
    if music_datas:
        update_view()

func update_view():
    music_index = $Control/selector.current_index
    if music_index < 0 or music_index >= music_datas.size():
        push_warning("無効なインデックスです")
        return

    var music = music_datas[music_index]

    $Control.music_name = music.title
    $Control.composer =  music.composer
    $Control.note_designer =  music.note_designer

    var level_values = {}
    for level in music.levels:
        level_values[level.level_name] = level.level_value

    $Control/LevelSelect.easy_value = level_values.get("easy", "")
    $Control/LevelSelect.medium_value = level_values.get("medium", "")
    $Control/LevelSelect.hard_value = level_values.get("hard", "")
    $Control/LevelSelect.kuso_value = level_values.get("kuso", "")
