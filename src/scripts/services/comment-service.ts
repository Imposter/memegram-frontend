import { ModelBase } from "./common";
import { Service, ServiceResult } from "../service";

export interface Comment extends ModelBase {
    post: string;
    name: string;
    comment: string;
}

export interface Settings {
	commentCharacterLimit: number;
}

export interface CreateCommentOptions {
	postId: string;
	comment: string;
	name?: string;
}

export interface FindCommentsOptions {
	postId: string;
    from?: Date;
    count?: number;
}

export class CommentService extends Service {
	constructor() {
		super();
	}

	public getName(): string {
		return "comment";
	}

	public async create(options: CreateCommentOptions): Promise<ServiceResult<Comment>> {
		var result = await this.sendJSONRequest<Comment>("POST", "/create", {}, options);

		this.observable.trigger(`service::${this.getName()}::create`, result);

		return result;
    }
    
	public async find(options?: FindCommentsOptions): Promise<ServiceResult<Comment[]>> {
		var result = await this.sendJSONRequest<Comment[]>("POST", "/find", {}, options);

		this.observable.trigger(`service::${this.getName()}::find`, result);

		return result;
	}
    
	public async getRandomName(postId: string): Promise<ServiceResult<string>> {
		var result = await this.sendJSONRequest<string>("POST", "/name", {}, {
            postId: postId
        });

		this.observable.trigger(`service::${this.getName()}::getRandomName`, result);

		return result;
	}

	public async getSettings(): Promise<ServiceResult<Settings>> {
		var result = await this.sendJSONRequest<Settings>("GET", "/settings", {}, {});

		this.observable.trigger(`service::${this.getName()}::getSettings`, result);

		return result;
	}
}