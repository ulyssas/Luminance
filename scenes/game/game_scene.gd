extends Node

var music_data: MusicData

func set_music_data(data: MusicData):
    music_data = data

func _ready():
    if music_data:
        print("ロード完了: ", music_data.get_info())
        print("レベル: ", music_data.levels[0].get_info())
        $Control.music_name = music_data.title
        $Control.composer =  music_data.composer
        $Control.level_name = music_data.levels[0].level_name
        $Control.level_value = music_data.levels[0].level_value
        $Control.jacket_path = music_data.texture_path
        print($Control.jacket_path)
