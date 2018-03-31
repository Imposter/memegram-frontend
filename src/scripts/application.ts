import * as riot from "riot";
import route from "riot-route";
import { Observable } from "./observable";
import { Service } from "./service";
import { AuthService } from "./services/auth-service";

export interface ApplicationOptions {
	// Constants
	name: string;
	date: Date;

	// View management
	targetView: string;
	availableViews: string[];
	defaultView: string;
}

export class Application extends Observable {
	// Constants
	public readonly name: string;
	public readonly date: Date;

	// View management
	private root?: riot.Tag; 
	private targetView: string;
	private availableViews: string[];
	private defaultView: string;
	private currentView?: riot.Tag;

	// Services
	public readonly services: { [key: string]: Service };

	constructor(opts: ApplicationOptions) {
		super();

		// Initialize constants
		this.name = opts.name;
		this.date = opts.date;

		// View management
		this.targetView = opts.targetView;
		this.availableViews = opts.availableViews;
		this.defaultView = opts.defaultView;

		// Initialize services
		this.services = {};

		// Setup view callbacks
		route(this.loadRoute);
	}

	public addService(service: Service) {
		this.services[service.getName()] = service;
	}

	public beginRouting(tag: riot.Tag) {
		this.root = tag;

		// Set app for root
		(this.root as any).app = this;

		// Begin routing
		route.start(true);

		// Update on all events
		this.root.on("*", function() {
			console.log("APP: ON UPDATE!"); // TODO: Test
			tag.update();
		});
	}

	// NOTE: This whole following code is wrong, it won't work, fuck man, fix this shit

	// NOTE: "this" refers to riot.Tag
	private loadView(view: string, args: any[]) {
		var app: Application = (this as any).app;

		if (app.currentView)
			app.currentView.unmount(true);

		var opts = {
			app: app, 
			args: args 
		};

		app.currentView = riot.mount("#app-body", app.targetView, opts)[0];
	}

	public loadRoute(view: string, ...args: any[]) {
		var app: Application = (this as any).app;
		if (app == null) app = this;

		if (view == "") {
			view = app.defaultView;
		}

		if (app.availableViews.indexOf(view) > -1) {
			app.loadView(`${view}-view`, args);
		} else {
			console.error(`View ${view} does not exist!`);
		}
	}
}

export var app: Application;

export function createApp(opts: ApplicationOptions): Application {
	app = new Application(opts);
	return app;
}