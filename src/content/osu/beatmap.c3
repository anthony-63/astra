module content::osu;

import std::collections::map;
import std::io::file;

def KVSection = HashMap(<String, String>);

struct Beatmap {
    KVSection* general;
    KVSection* metadata;
    KVSection* difficulty;
}

fn Beatmap! open_beatmap(String path) @private {
    Beatmap map;

    BeatmapParser parser = new_parser(&map, path);
    parser.parse();
    parser.free();

    return map;
}