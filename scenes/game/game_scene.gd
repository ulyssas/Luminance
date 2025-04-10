extends Node

var music_data: MusicData
var level_list_index: int # music_data.levelのインデックス

func set_music_data(data: MusicData, index: int):
    music_data = data
    level_list_index = index

func _ready():
    Fade.fade_in(1.5)

    if music_data:
        print("ロード完了: ", music_data.get_info())
        print("レベル: ", music_data.levels[level_list_index].get_info())
        $Control.music_name = music_data.title
        $Control.composer =  music_data.composer
        $Control.level_name = music_data.levels[level_list_index].level_name
        $Control.level_value = music_data.levels[level_list_index].level_value
        $Control.jacket_path = music_data.texture_path
        print($Control.jacket_path)
