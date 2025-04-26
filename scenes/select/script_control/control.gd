extends Control

const SelectState = preload("res://scenes/select/select_state.gd")

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

func _ready():
    set_state(SelectState.State.SELECT_TRACKS)

func set_state(state):
    $MusicInfo.is_selected = (state != SelectState.State.SELECT_TRACKS)
    $MusicSelect.disabled = (state != SelectState.State.SELECT_TRACKS)
    $fade.is_selected = (state != SelectState.State.SELECT_TRACKS)
    $BottomBar.is_music_select = (state == SelectState.State.SELECT_TRACKS)
    $BottomBar.is_level_select = (state == SelectState.State.SELECT_LEVELS)
    $LevelSelect.disabled = (state != SelectState.State.SELECT_LEVELS)
    $LevelSelect.is_visible = (state != SelectState.State.OPTIONS)
    $OptionSelect.disabled = (state != SelectState.State.OPTIONS)
    $OptionSelect.is_visible = (state == SelectState.State.OPTIONS)

    match state:
        SelectState.State.SELECT_TRACKS:
            $Title.set_title("Select Tracks")
        SelectState.State.SELECT_LEVELS:
            $Title.set_title("Select Levels")
        SelectState.State.OPTIONS:
            $Title.set_title("Options")
