extends Panel

@export var music_name: String = "":
    set(value):
        music_name = value
        $music_name.music_name = music_name

@export var composer: String = "":
    set(value):
        composer = value
        $composer.text = composer

@export var level_name: String = "":
    set(value):
        level_name = value
        $level_name.text = level_name

@export var level_value: String = "":
    set(value):
        level_value = value
        $level_value.text = level_value
