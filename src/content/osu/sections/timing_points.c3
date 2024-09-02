module sections;

import std::collections::list;

import std::io;

struct BeatmapTimingPointSection {
    List(<TimingPoint>) points;
}

struct TimingPoint {
    usz time;
    double beat_length;
    usz meter;
    usz sample_set;
    usz sample_index;
    usz volume;
    bool uninherited;
    usz effects;
}

fn void BeatmapTimingPointSection.parse_line(this, String line) {
    String[] point_info = line.split(",");
    if(point_info.len < 8 || line.starts_with("//")) {
        // io::printfn("Invalid timing point: %s", line);
        return;
    }

    this.points.push(TimingPoint {
        .time = (usz)point_info[0].to_long()!!,
        .beat_length = point_info[1].to_double()!!,
        .meter = (usz)point_info[2].to_long()!!,
        .sample_set = (usz)point_info[3].to_long()!!,
        .sample_index = (usz)point_info[4].to_long()!!,
        .volume = (usz)point_info[5].to_long()!!,
        .uninherited = point_info[6].to_long()!! == 1,
        .effects = (usz)point_info[7].to_long()!!,
    });
}