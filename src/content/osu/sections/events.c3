module sections;

import std::collections::list;
import std::io;

struct BeatmapEventSection {
    List(<Event>) events;
}

enum EventType {
    EVENT_BACKGROUND,
    EVENT_VIDEO,
    EVENT_BREAK,
}

struct Event {
    EventType type;
    usz start_time;
    usz x_offs;
    usz y_offs;
    String filename;
    usz end_time;
}

fn void BeatmapEventSection.parse_line(this, String line) {
    String[] ev_info = line.split(",");
    if(line.starts_with("//") || ev_info.len < 3) return;

    switch(ev_info[0]) {
        case "Background": nextcase;
        case "0": this.parse_background_event(ev_info);
        case "Video": nextcase;
        case "1": this.parse_video_event(ev_info);
        case "Break": nextcase;
        case "2": this.parse_break_event(ev_info);
        default:
    }
}

fn void BeatmapEventSection.parse_background_event(this, String[] ev_info) @private {
    if(ev_info.len < 5) return;
    this.events.push(Event {
        .type = EVENT_BACKGROUND,
        .start_time = (usz)ev_info[1].to_long()!!,
        .filename = ev_info[2],
        .x_offs = (usz)ev_info[3].to_long()!!,
        .y_offs = (usz)ev_info[4].to_long()!!,
    });
}

fn void BeatmapEventSection.parse_video_event(this, String[] ev_info) @private {
    if(ev_info.len < 5) return;
        this.events.push(Event {
        .type = EVENT_VIDEO,
        .start_time = (usz)ev_info[1].to_long()!!,
        .filename = ev_info[2],
        .x_offs = (usz)ev_info[3].to_long()!!,
        .y_offs = (usz)ev_info[4].to_long()!!,
    });
}

fn void BeatmapEventSection.parse_break_event(this, String[] ev_info) @private {
    if(ev_info.len < 3) return;
    this.events.push(Event {
        .type = EVENT_BREAK,
        .start_time = (usz)ev_info[1].to_long()!!,
        .end_time = (usz)ev_info[2].to_long()!!,
    });
}