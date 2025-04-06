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


# level_values
func _on_easy_text_changed(new_text):
    $LevelSelect.easy_value = new_text

func _on_medium_text_changed(new_text):
    $LevelSelect.medium_value = new_text

func _on_hard_text_changed(new_text):
    $LevelSelect.hard_value = new_text

func _on_kuso_text_changed(new_text):
    $LevelSelect.kuso_value = new_text


# notes
func _on_music_name_text_changed(new_text):
    $MusicInfo.music_name = new_text

func _on_comp_text_changed(new_text):
    $MusicInfo.composer = new_text

func _on_noted_text_changed(new_text):
    $MusicInfo.note_designer = new_text

func _on_title_text_changed(new_text):
    $Title.text = new_text
