import * as riot from "riot";
import route from "riot-route";
import { Observable } from "./observable";
import { Service } from "./service";

export interface ApplicationOptions {
	// Constants
	name: string;
	date: Date;
	options: any;

	// View management
	targetView: string;
	availableViews: string[];
	defaultView: string;

	// Services
	serverUrl: string;
	serverTimeout: number;
	services: Service[];
}

export class Application {
	// Constants
	public readonly name: string;
	public readonly date: Date;
	public readonly options: any;

	// View management
	private root?: riot.Tag; 
	private targetView: string;
	private availableViews: string[];
	private defaultView: string;
	private currentView?: riot.Tag;

	// Services
	public serverUrl: string;
	public serverTimeout: number;
	public readonly services: Service[];

	constructor(opts: ApplicationOptions) {
		// Initialize constants
		this.name = opts.name;
		this.date = opts.date;
		this.options = opts.options;

		// View management
		this.targetView = opts.targetView;
		this.availableViews = opts.availableViews;
		this.defaultView = opts.defaultView;

		// Services
		this.serverUrl = opts.serverUrl;
		this.serverTimeout = opts.serverTimeout;
		this.services = opts.services;

		// Setup view callbacks
		route(this.loadRoute);
	}

	public getService<TService extends Service>(name: string): TService {
		for (var service of this.services) {
			if (service.getName() == name) {
				return service as TService;
			}
		}
		
		throw new Error(`Service ${name} not found`);
	}

	public initialize(tag: riot.Tag) {
		this.root = tag;

		// Initialize services
		Service.serverUrl = this.serverUrl;
		Service.timeout = this.serverTimeout;

		for (var service of this.services) {
			service.initialize(this.root);
		}

		// Begin routing
		route.start(true);

		// Causes call stack overflow
		/*
		// Update on all events
		this.root.on("*", function() {
			tag.update();
		});
		*/
	}

	private loadView(view: string, args: any) {
		if (app.currentView)
			app.currentView.unmount(true);

		var opts = {
			app: app, 
			args: args
		};

		app.currentView = riot.mount(app.targetView, view, opts)[0];
	}

	public loadRoute(view: string, args: any) {
		if (view == "") {
			view = app.defaultView;
		}

		if (app.availableViews.indexOf(view) > -1) {
			app.loadView(`${view}-view`, args);
		} else {
			console.error(`View ${view} does not exist!`);
		}
	}

	public mountElement(selector: string | Element, view: string, args: any) {
		if (app.availableViews.indexOf(view) > -1) {
			riot.mount(selector, `${view}-view`, args);
		} else {
			console.error(`View ${view} does not exist!`);
		}
	}

	public on(event: string, callback: riot.ObservableCallback) {
		if (this.root) this.root.on(event, callback);
		return this;
	}

	public one(event: string, callback: riot.ObservableCallback) {
		if (this.root) this.root.one(event, callback);
		return this;
	}

	public off(event: string, callback?: riot.ObservableCallback) {
		if (this.root) this.root.off(event, callback);
		return this;
	}

	public trigger(event: string, ...args: any[]) {
		if (this.root) this.root.trigger(event, args);
		return this;
	}
}

export var app: Application;

export function createApp(opts: ApplicationOptions): Application {
	app = new Application(opts);
	return app;
}