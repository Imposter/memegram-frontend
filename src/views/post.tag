<post-view class="row">
    <div class="col s12">
        <!-- m8 offset-m2 -->
        <div class="card">
            <div class="card-image waves-effect waves-block waves-light">
                <img class="activator lazy lazy-img" data-src={ image }>
            </div>
            <div class="card-content">
                <span class="card-title activator grey-text text-darken-4">{ name }
                    <i class="material-icons right">comment</i>
                </span>
                <div class="section">
                    <span class="right">posted { timeago().format(new Date(createdAt)) }</span>
                    <p>{ caption }</p>
                </div>
                <div class="divider" if={ topics }></div>
                <div class="tag-section" if={ topics }>
                    <div class="chip" each={ topic in topics }>{ topic }</div>
                </div>
            </div>
            <div class="card-reveal">
                <span class="card-title grey-text text-darken-4">Comments
                    <i class="material-icons right">close</i>
                </span>
                <ul id="comments-collection-{ id }" class="collection card-reveal-comments">
                    <li class="collection-item avatar" each={ comments }>
                        <img class="circle" data-avatar={ name }>
                        <span class="title">{ name }</span>
                        <span class="right">posted { timeago().format(new Date(createdAt)) }</span>
                        <p>{ comment }</p>
                        <!-- TODO: Share button, which takes to individual display menu with just one post (used on create too!) -->
                    </li>
                </ul>
                <a class="btn-floating btn-large waves-effect waves-light right modal-trigger" href="#create-comment-{ id }">
                    <i class="material-icons">create</i>
                </a>
            </div>
        </div>
    </div>

    <div id="create-comment-{ id }" class="modal">
        <div class="modal-content">
            <h4>Create comment on { name }'s post</h4>
            <p>
                Please enter the following information to create your comment. By proceeding, you acknowledge that you agree to our
                <a href="#" onclick={ openTermsOfService }>terms of service</a>.
            </p>
            <div class="section"></div>
            <div class="row">
                <form class="col s12">
                    <div class="row">
                        <div class="input-field col s12">
                            <input id="input-username-{ id }" type="text" value={ commenterName }>
                            <label for="input-username-{ id }" class="active">Name</label>
                        </div>
                        <div class="input-field col s12">
                            <textarea id="input-comment-{ id }" class="materialize-textarea"></textarea>
                            <label for="input-comment-{ id }">Comment</label>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="modal-footer">
            <a id="button-create-comment-{ id }" href="#" onclick={ postComment } class="modal-action modal-close waves-effect btn">Create</a>
        </div>
    </div>

    <yield/>

    <script>
        import { app } from "../scripts/application";

        // Get comment service
        const CommentService = app.getService("comment");

        // Loaded comments
        this.comments = [];

        this.getComments = async (e) => {
            // From
            var count = app.options.commentFetchLimit;
            var from = null;
            if (this.comments != null && this.comments.length > 0) {
                var lastComment = this.comments[this.comments.length - 1];
                from = lastComment.createdAt;
                count++;
            }

            // Get comments
            var result = await CommentService.find({
                postId: this.id,
                count: count,
                from: from
            });

            // Add comment if it doesn't exist already
            var added = 0;
            for (var c of result.data) {
                var add = true;
                for (var comment of this.comments) {
                    if (comment.id == c.id) {
                        add = false;
                        break;
                    }
                }

                if (add) {
                    this.comments.push(c);
                    added++;
                }
            }

            console.log(`Loaded ${added} new comments`);

            // Update
            this.update();
        };

        this.postComment = async (e) => {
            // Get comment details
            var name = $(`#input-username-${this.id}`).val();
            var comment = $(`#input-comment-${this.id}`).val();

            // Check if comment exists
            if (!comment.length) {
                M.toast({ html: "Comment cannot be empty!" });
                return;
            }

            // Check if comment is too long
            if (comment.length > this.settings.commentCharacterLimit) {
                M.toast({ html: `Comment cannot exceed ${this.settings.commentCharacterLimit} characters!` });
                return;
            }
                
            // Disable create button
            $(`#button-create-comment-${this.id}`).addClass("disabled");

            // Create post
            try {
                await CommentService.create({
                    postId: this.id,
                    name: name,
                    comment: comment
                });

                // Get new comments
                await this.getComments();
            } catch (error) {
                M.toast({ html: `An error occurred while trying to create comment` });
                M.toast({ html: error });
            }
                
            // Enable create button
            $(`#button-create-comment-${this.id}`).removeClass("disabled");
        }

        this.on("updated", function () {
            // Set avatars for all comments/post
            $(`img[data-avatar]`).avatar({
                size: 42 // px
            });
        });

        this.on("mount", async function () {
            $(".lazy-img").lazy({
                effect: "fadeIn",
                effectTime: 1000,
                threshold: 0
                //TODO: defaultImage/placeholder (some placeholder gif?)
            });

            // Get settings
            var settingsResult = await CommentService.getSettings();
            this.settings = settingsResult.data;

            // Set caption length limit
            $(`#input-comment-${this.id}`).attr("data-length", this.settings.commentCharacterLimit);
            $(`#input-comment-${this.id}`).characterCounter();

            // Initialize create comment modal
            $(`#create-comment-${this.id}`).modal();

            // Get a name for the commenter
            var result = await CommentService.getRandomName(this.id);
            var commenterName = result.data;
            this.update({
                commenterName: commenterName
            });

            // Get comments
            await this.getComments();

            // Download more data when scrolled to bottom
            var self = this;
            this.scrollHandler = async function () { // TODO: Only update if scrolled down!
                if ($(this).scrollTop() + $(this).innerHeight() + app.options.scrollLoadY >= $(this)[0].scrollHeight) {
                    // Get comments
                    await self.getComments();
                }
            };

            // Add scroll listener
            $(`#comments-collection-${this.id}`).on("scroll", this.scrollHandler);

            this.on("before-unmount", function () {
                // Remove scroll listener
                $(`#comments-collection-${this.id}`).off("scroll", this.scrollHandler);
            });
        });

		this.openTermsOfService = e => app.loadRoute("tos");
    </script>
</post-view>