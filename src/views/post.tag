<post-view class="row">
    <div class="col s12">
        <!-- m8 offset-m2 -->
        <div class="card">
            <div class="card-image waves-effect waves-block waves-light">
                <img class="activator lazy lazy-img" data-src={ url } onclick={ getComments }>
            </div>
            <div class="card-content">
                <span class="card-title activator grey-text text-darken-4" onclick={ getComments }>{ name }
                    <i class="material-icons right">comment</i>
                </span>
                <div class="section">
                    <p>{ caption }</p>
                </div>
                <div class="divider" if={ topics }></div>
                <div class="tag-section" if={ topics }>
                    <topic-view each={ topic in topics }></topic-view>
                </div>
            </div>
            <div class="card-reveal">
                <span class="card-title grey-text text-darken-4">Comments
                    <!-- TODO: Add create comment button here -->
                    <i class="material-icons right">close</i>
                </span>
                <div class="collection card-reveal-comments" if={ comments }>
                    <!-- TODO: Load comments -->
                    <comment-view each={ comments }></comment-view> <!-- TODO: Delay load -->
                </div>
            </div>
        </div>
    </div>
    <yield/>

    <script>
        this.getComments = (e) => {
            console.log("Loading comments!");
        };

        this.on("mount", function() {
            $(".lazy-img").lazy({
                effect: "fadeIn",
                effectTime: 1000,
                threshold: 0
            });
        });
    </script>
</post-view>

<topic-view>
    <div class="chip">{ topic }</div>
</topic-view>

<comment-view class="collection-item avatar">
    <span class="title">{ name }</span>
    <p>{ comment }</p>
</comment-view>