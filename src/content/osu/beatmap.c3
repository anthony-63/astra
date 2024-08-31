module content::osu;

import std::collections::map;
import std::io::file;
import sections;

struct Beatmap {
    BeatmapGeneralSection general;
}

fn Beatmap! open_beatmap(String path) @private {
    Beatmap map;
    BeatmapParser parser = new_parser(&map, path);
    parser.parse();
    parser.free();
    return map;
}