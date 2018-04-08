<display-view class="container">

    <post-view each={ posts }></post-view>

    <script>
        import { app } from "../scripts/application";

        // Get post service
        const PostService = app.getService("post");

        // Loaded posts
        this.posts = [];

        this.getPosts = async (e) => {
            // Get topics from parameters
            var topics = [];
            if (this.opts.args) {
                topics = this.opts.args.topics;
            }

            // TODO: Get search parameters

            // From
            var from = null;
            if (this.posts != null && this.posts.length > 0) {
                var lastPost = this.posts[this.posts.length - 1];
                from = lastPost.createdAt;
            }

            // Get posts
            var result = await PostService.find({
                topics: topics,
                count: app.options.postFetchLimit,
                from: from
            });

            // Update posts to have URLs to image service
            for (var post of result.data) {
                post.url = PostService.getImageUrl(post.id);
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
            $(window).scroll(async function () {
                if ($(window).scrollTop() + $(window).height() == $(document).height()) {
                    // Get posts
                    await self.getPosts();
                }
            });

            // Lazy load
            $(".lazy").lazy({
                effect: "fadeIn",
                effectTime: 1000,
                threshold: 0
            });
        });
    </script>
</display-view>