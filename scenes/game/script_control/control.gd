extends Control

@export var score_value: float = 0:
    set(value):
        score_value = value
        $Score.score_value = value

@export var perfect_value: float = 0:
    set(value):
        perfect_value = value
        $PGGM.perfect_value = value

@export var great_value: float = 0:
    set(value):
        great_value = value
        $PGGM.great_value = value

@export var good_value: float = 0:
    set(value):
        good_value = value
        $PGGM.good_value = value

@export var miss_value: float = 0:
    set(value):
        miss_value = value
        $PGGM.miss_value = value

@export var music_name: String = "unknown music":
    set(value):
        music_name = value
        $MusicInfo.music_name = value

@export var composer: String = "unknown composer":
    set(value):
        composer = value
        $MusicInfo.composer = value

@export var level_name: String = "unknown level":
    set(value):
        level_name = value
        $MusicInfo.level_name = value

@export var level_value: String = "0":
    set(value):
        level_value = value
        $MusicInfo.level_value = value
