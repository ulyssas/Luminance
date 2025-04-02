extends Node

var music_data: MusicData

func set_music_data(data: MusicData):
    music_data = data

func _ready():
    if music_data:
        print("ロード完了: ", music_data.get_info())
        $Control.music_name = music_data.title
        $Control.composer =  music_data.composer
        #$Control.level_name
        #$Control.level_value
