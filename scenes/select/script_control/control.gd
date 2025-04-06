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
