import * as jQuery from "jquery";

export class ServiceResult<TData> {
	public code: number;
	public data: TData | null;

	constructor() {
		this.code = 0;
		this.data = null;
	}

	public hasData() {
		return this.data != null;
	}
}

export abstract class Service {
	public static readonly RequestTimeout: number = 1000;

	private static services: { [key: string]: Service };
	public static serverUrl: string;
	public static timeout: number = Service.RequestTimeout;

	public abstract getName(): string;

	protected sendJSONRequest<TData>(method: string, path: string,
		headers: { [key: string]: string }, data: object): Promise<ServiceResult<TData>> {
		// Create request url
		var requestUrl = `${Service.serverUrl}/${this.getName()}/${path}`.replace(/([^:]\/)\/+/g, "$1");

		// Create headers map
		if (headers == null) {
			headers = {};
		}

		return new Promise(function (resolve, reject) {
			jQuery.ajax({
				async: true,
				url: requestUrl,
				data: JSON.stringify(data),
				cache: false,
				contentType: "application/json",
				processData: false,
				method: method,
				type: method,
				headers: headers,
				timeout: Service.timeout,
				success: function (data) {
					if (data.error != null) {
						reject(new Error(data.error));
					}

					var result = new ServiceResult<TData>();
					result.code = data.code;
					result.data = data.data;

					resolve(result);
				},
				error: function (response, status, error) {
					reject(new Error(error));
				}
			});
		});
	}
}

export enum Role {
    Admin,
    Moderator,
    User
}

export interface AuthCreateResult {
	name: string;
	email: string;
	role: Role;
}

export class AuthService extends Service {
	public getName() {
		return "auth";
	}

	public async test() {
		return await this.sendJSONRequest("GET", "/test", {}, {});
	}

	public async login(email: string, password: string) {
		// TODO: Parse request
		return await this.sendJSONRequest<AuthCreateResult>("POST", "/login", {}, {
			email: email,
			password: password
		});
	}
}

var s = new AuthService();
(async function () {
	Service.serverUrl = "http://localhost:12400/api/";
	try {
		console.log(await s.login("eyaz.rehman@uoit.net", "pwd123"));
		var r = await s.test();
	} catch (error) {
		console.log(error.toString());
	}
})();

// Anonymous posting! / IDs stored in cookies/sessions, admin/moderator can only delete posts
// Names generated like AnonymousCrocodile
// Anonymous posting! / no following / profile views, have my posts, admin/moderator/owner who can delete posts
// TODO: Separate shard/database for images