<display-view class="container">

    <post-view each={ posts }></post-view>

    <script>
        import { app } from "../scripts/application";

        // Get post service
        const PostService = app.getService("post");

        // Loaded posts
        this.posts = [];

        this.getPosts = async (e) => {
            // Get parameters
            var id = null;
            var topics = [];
            var keywords = null;
            if (this.opts.args) {
                id = this.opts.args.id;
                topics = this.opts.args.topics;
                keywords = this.opts.args.keywords;
            }

            // From
            var count = app.options.postFetchLimit;
            var from = null;
            if (this.posts != null && this.posts.length > 0) {
                var lastPost = this.posts[this.posts.length - 1];
                from = lastPost.createdAt;
                count++;
            }

            // Get posts
            var result = await PostService.find({
                id: id,
                keywords: keywords,
                topics: topics,
                count: count,
                from: from
            });

            // Update posts to have URLs to image service, and date strings
            for (var post of result.data) {
                post.image = PostService.getImageUrl(post.id);
            }

            // Add post if it doesn't exist already
            var added = 0;
            for (var p of result.data) {
                var add = true;
                for (var post of this.posts) {
                    if (post.id == p.id) {
                        add = false;
                        break;
                    }
                }

                if (add) {
                    this.posts.push(p);
                    added++;
                }
            }

            console.log(`Loaded ${added} new posts`);

            // Update
            this.update();
        };

        this.on("mount", async function () {
            // Get posts
            await this.getPosts();

            // Download more data when scrolled to bottom
            var self = this;
            this.scrollHandler = async function () {
                if ($(this).scrollTop() + $(this).height() + app.options.scrollLoadY >= $(document).height()) {
                    // Get posts
                    await self.getPosts();
                }
            };

            // Add scroll listener
            $(window).on("scroll", this.scrollHandler);

            this.on("before-unmount", function() {
                // Remove scroll listener
                $(window).off("scroll", this.scrollHandler);
            });
        });
    </script>
</display-view>