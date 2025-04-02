extends Node

const MusicData = preload("res://scripts/MusicData.gd")  # クラスをロード

func load_music_data() -> Array[MusicData]:
    var music_data_list: Array[MusicData] = []
    var dir = DirAccess.open("res://musics")
    
    if dir:
        dir.list_dir_begin()
        var folder_name = dir.get_next()
        
        while folder_name != "":
            if dir.current_is_dir():
                var file_path = "res://musics/%s/data.txt" % folder_name
                var file = FileAccess.open(file_path, FileAccess.READ)
                
                if file:
                    var lines = []
                    while not file.eof_reached():
                        lines.append(file.get_line().strip_edges())

                    if lines.size() >= 9:
                        var music = MusicData.new(
                            lines[0],         # title
                            lines[1],         # texture_path
                            lines[2],         # composer
                            lines[3],         # note_designer
                            lines[4] == "true",  # has_kuso
                            int(lines[5]),    # priority
                            int(lines[6]),    # sabi_begin
                            int(lines[7]),    # sabi_end
                            float(lines[8])   # velocity
                        )
                        music_data_list.append(music)

            folder_name = dir.get_next()
        
        dir.list_dir_end()
    
    return music_data_list
