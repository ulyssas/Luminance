extends Panel

@export var music_name: String = "":
    set(value):
        music_name = value
        $music_name.music_name = music_name

@export var composer: String = "":
    set(value):
        composer = value
        $composer.creator_name = composer

@export var note_designer: String = "":
    set(value):
        note_designer = value
        $note_designer.creator_name = note_designer
