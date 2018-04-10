import { ModelBase } from "./common";
import { Service, ServiceResult } from "../service";

export interface Post extends ModelBase {
	topics: string[];
	name: string;
	caption: string;
	image: string;
}

export interface Settings {
	postCharacterLimit: number;
	postImageSizeLimit: number;
}

export interface CreatePostOptions {
	topics: string[];
	caption: string;
	file: any;
	name?: string;
}

export interface FindPostsOptions {
	id?: string;
	topics?: string[];
	keywords?: string;
	from?: Date;
	count?: number;
}

export class PostService extends Service {
	constructor() {
		super();
	}

	public getName(): string {
		return "post";
	}

	public async create(options: CreatePostOptions): Promise<ServiceResult<Post>> {
		var result = await this.sendFormRequest<Post>("POST", "/create", {}, options);

		this.observable.trigger(`service::${this.getName()}::create`, result);

		return result;
	}

	public async getRandomName(): Promise<ServiceResult<string>> {
		var result = await this.sendJSONRequest<string>("GET", "/name", {}, {});

		this.observable.trigger(`service::${this.getName()}::getRandomName`, result);

		return result;
	}

	public async getSettings(): Promise<ServiceResult<Settings>> {
		var result = await this.sendJSONRequest<Settings>("GET", "/settings", {}, {});

		this.observable.trigger(`service::${this.getName()}::getSettings`, result);

		return result;
	}

	public async find(options?: FindPostsOptions): Promise<ServiceResult<Post[]>> {
		var result = await this.sendJSONRequest<Post[]>("POST", "/find", {}, options);

		this.observable.trigger(`service::${this.getName()}::find`, result);

		return result;
	}

	public getImageUrl(postId: string): string {
		return this.buildUrl(`/image/${postId}`);
	}
}