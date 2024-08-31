module astra;
import std::io;

import app;
import content::osu;

fn int main(String[] args) {
	
	BeatmapSet! mapset = osu::open_beatmapset("C:/Users/antho/AppData/Local/osu!/Songs/991300 Fleshgod Apocalypse - The Deceit");
	
	app::Astra astra = app::astra_init("osu!astra", 1280, 720);
	astra.run();
	astra.close();
	
	return 0;
}
