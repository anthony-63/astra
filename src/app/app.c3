module app;

import sdl3;
import sdl3::subsystem;
import sdl3::event_type;
import std::thread;
import std::io;

struct Astra {
    sdl3::Window *window;
    sdl3::Renderer *renderer;

    usz now;
    usz last;
    double dt;

    bool running;
}

fn Astra astra_init(ZString title, usz width, usz height) {
    Astra astra = Astra{};
	if(sdl3::init(subsystem::VIDEO | subsystem::EVENTS) < 0) {
		sdl3::log_error("Failed to initialize SDL3: %s", sdl3::get_error());
        thread::exit(-1);
	}
    astra.last = 0;
    astra.now = 0;

    astra.window = sdl3::create_window(title, (int)width, (int)height, 0);
    astra.renderer = sdl3::create_renderer(astra.window, null);

    return astra;
}

fn void Astra.step_dt(&this) @private {
    this.last = this.now;
    this.now = sdl3::get_performance_counter();
    this.dt = (double)((double)(this.now - this.last) * 1000 / (double)sdl3::get_performance_frequency());
}

fn void Astra.render(this) @private {
    sdl3::set_render_draw_color(this.renderer, 30, 30, 30, 255);
	sdl3::render_clear(this.renderer);
	defer sdl3::render_present(this.renderer);
}

fn void Astra.update(&this) @private {

}

fn void Astra.run(&this) {
    this.running = true;

    while(this.running) {
        sdl3::Event ev;
        if(sdl3::poll_event(&ev)) {
            switch(ev.type) {
                case event_type::QUIT: this.running = false;
            }
        }
        this.step_dt();
        this.update();
        this.render();
    }
}

fn void Astra.close(this) {
	sdl3::destroy_renderer(this.renderer);
    sdl3::destroy_window(this.window);
    sdl3::quit();
}