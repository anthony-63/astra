module content::osu;

import std::collections::list;
import std::io::path;
import std::io;
import sdl3;

struct BeatmapSet {
    List(<Beatmap>) difficulties;
}

fn BeatmapSet! open_beatmapset(String dir_path) {
    BeatmapSet mapset;

    // @pool() {
    //     Path path = path::new(dir_path)!;
    //     foreach(i, p : path::new_ls(path)!) {
    //         if(p.str_view().ends_with(".osu")) {
    //             mapset.difficulties.push(open_beatmap(dir_path.concat("/".concat(p.str_view())))!);
    //         }
    //     }
    // };

    ZString[] maps = sdl3::glob_directory((ZString)dir_path, "*.osu");
    foreach(file: maps) {
        mapset.difficulties.push(open_beatmap(dir_path.concat("/".concat(file.str_view())))!);
    }

    return mapset;
}