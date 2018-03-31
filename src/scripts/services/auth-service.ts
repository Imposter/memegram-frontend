import { RoleType } from "./common";
import { Observable } from "../observable";
import { Service } from "../service";

export interface AuthResult {
	email: string;
	role: RoleType;
}

export class AuthService extends Service {
	public loggedIn: boolean;

	constructor(observable: Observable) {
		super(observable);

		// Initialize variables
		this.loggedIn = false;
	}

	public getName(): string {
		return "auth";
	}

	public async login(email: string, password: string) {
		// Parse request
		var result = await this.sendJSONRequest<AuthResult>("POST", "/login", {}, {
			email: email,
			password: password
		});

		this.observable.trigger("auth::login", result);

		return result;
	}

	public async create(email: string, password: string) {
		// Parse request
		var result = await this.sendJSONRequest<AuthResult>("POST", "/create", {}, {
			email: email,
			password: password
		});

		this.observable.trigger("auth::create", result);

		return result;
	}
}