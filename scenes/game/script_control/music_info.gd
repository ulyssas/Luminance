extends Panel

@export var music_name: String = "":
    set(value):
        music_name = value
        $music_name.music_name = music_name

@export var composer: String = "":
    set(value):
        composer = value
        $composer.composer_name = composer

@export var level_name: String = "":
    set(value):
        level_name = value
        $level_disp/level_name.text = level_name

@export var level_value: String = "":
    set(value):
        level_value = value
        $level_disp/level_value.text = level_value

@export var jacket_path: String = "":
    set(value):
        if value != "":
            jacket_path = value
            var image = Image.load_from_file(jacket_path)
            $jacket.texture = ImageTexture.create_from_image(image)
