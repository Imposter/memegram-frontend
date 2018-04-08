import * as riot from "riot";

export class Observable implements riot.Observable {
	constructor() {
		// Dirty hacks!
		this.on = (e, c) => { return this; };
		this.one = (e, c) => { return this; };
		this.off = (e, c) => { return this; };
		this.trigger = (e, ...args) => { return this; };

		// This initializes the observable interface
		riot.observable(this);
	}

	on: (event: string, callback: riot.ObservableCallback) => this;
	one: (event: string, callback: riot.ObservableCallback) => this;
	off: (event: string, callback?: riot.ObservableCallback | undefined) => this;
	trigger: (event: string, ...args: any[]) => this;
}

export class Observer {
	private o: Observable;

	constructor(observable: Observable) {
		this.o = observable;
	}

	protected get observable() {
		return this.o;
	}
}

export class LatentObserver {
	private o?: Observable;

	public initialize(observable: Observable) {
		this.o = observable;
	}

	protected get observable(): Observable {
		return this.o as Observable;
	}
}