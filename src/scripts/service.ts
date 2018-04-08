import * as jQuery from "jquery";
import { LatentObserver } from "./observable";

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

export abstract class Service extends LatentObserver {
	public static readonly RequestTimeout: number = 1000;

	private static services: { [key: string]: Service };
	public static serverUrl: string;
	public static timeout: number = Service.RequestTimeout;

	public abstract getName(): string;

	public buildUrl(path: string) {
		return `${Service.serverUrl}/${this.getName()}/${path}`.replace(/([^:]\/)\/+/g, "$1");
	}

	public sendFormRequest<TData>(method: string, path: string,
		headers: { [key: string]: string }, data: any): Promise<ServiceResult<TData>> {
		// Create request url
		var requestUrl = `${Service.serverUrl}/${this.getName()}/${path}`.replace(/([^:]\/)\/+/g, "$1");

		// Create headers map
		if (headers == null) {
			headers = {};
		}

		// Set form data
		var formData = new FormData();
		for (var key in data) {
			var value = data[key];
			if (Array.isArray(value)) {
				value = JSON.stringify(value);
			}

			formData.append(key, value);
		}

		return new Promise(function (resolve, reject) {
			jQuery.ajax({
				async: true,
				url: requestUrl,
				data: formData,
				cache: false,
				contentType: false,
				processData: false,
				method: method,
				type: method,
				headers: headers,
				timeout: Service.timeout,
				xhrFields: {
					withCredentials: true
				},
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

	public sendJSONRequest<TData>(method: string, path: string,
		headers: { [key: string]: string }, data: any): Promise<ServiceResult<TData>> {
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
				xhrFields: {
					withCredentials: true
				},
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