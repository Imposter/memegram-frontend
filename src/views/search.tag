<search-view class="container">
    <div class="row">
        <div class="col s12 m8 offset-m2">
            <div class="card">
                <div class="card-content black-text">
                    <span class="card-title">Search Posts</span>
                    <p>
                        Please enter the following information to create your post. By proceeding, you acknowledge that you agree to our
                        <a href="#" onclick={ openTermsOfService }>terms of service</a>.
                    </p>
                    <div class="section"></div>
                    <div class="row">
                        <form class="col s12">
                            <div class="row">
                                <div class="input-field col s12">
                                    <input id="input-keywords" type="text">
                                    <label for="input-keywords" class="active">Caption Keywords</label>
                                </div>
                                <div class="input-field col s12">
                                    <div id="input-topics-chips" class="chips chips-placeholder">
                                        <input id="input-topics" class="">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="card-action">
                    <button class="btn waves-effect waves-light" type="submit" onclick={ findPosts }>
                        <i class="material-icons left">search</i>
                        Search
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        import { app } from "../scripts/application";

        this.on("mount", async function () {
            // Initialize chips
            $("#input-topics-chips").chips({
                placeholder: "Enter a topic",
                secondaryPlaceholder: "+Topic"
            });
        });

        this.findPosts = (e) => {
            // Get details
            var keywords = $("#input-keywords").val();
            var topics = $("#input-topics-chips")[0].M_Chips.chipsData;

            // Covnert topic tags into an array of strings
            var topicArray = [];
            for (var topic of topics) {
                topicArray.push(topic.tag);
            }

            // Redirect
            app.loadRoute("display", {
                keywords: keywords,
                topics: topicArray
            });
        };

		this.openTermsOfService = e => app.loadRoute("tos");
    </script>
</search-view>