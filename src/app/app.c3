module app;

import sdl3;
import sdl3::subsystem;
import sdl3::event_type;
import std::thread;

struct Astra {
    sdl3::Window *window;
    sdl3::Renderer *renderer;
    bool running;
}

fn Astra astra_init(ZString title, usz width, usz height) {
    Astra astra = Astra{};
	if(sdl3::init(subsystem::VIDEO | subsystem::EVENTS) < 0) {
		sdl3::log_error("Failed to initialize SDL3: %s", sdl3::get_error());
        thread::exit(-1);
	}

    astra.window = sdl3::create_window(title, (int)width, (int)height, 0);
    astra.renderer = sdl3::create_renderer(astra.window, null);
    
    return astra;
}

fn void Astra.render(this) @private {
    sdl3::set_render_draw_color(this.renderer, 30, 30, 30, 255);
	sdl3::render_clear(this.renderer);
	defer sdl3::render_present(this.renderer);

    
}

fn void Astra.run(this) {
    this.running = true;

    while(this.running) {
        sdl3::Event ev;
        if(sdl3::wait_event(&ev)) {
            switch(ev.type) {
                case event_type::QUIT: this.running = false;
            }
        }
        this.render();
    }
}

fn void Astra.close(this) {
	sdl3::destroy_renderer(this.renderer);
    sdl3::destroy_window(this.window);
    sdl3::quit();
}