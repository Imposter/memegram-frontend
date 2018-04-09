<create-view class="container">
    <div class="row">
        <div class="col s12 m8 offset-m2">
            <div class="card">
                <div class="card-content black-text">
                    <span class="card-title">Create Post</span>
                    <p>
                        Please enter the following information to create your post. By proceeding, you acknowledge that you agree to our
                        <a href="#tos">terms of service</a>.
                    </p>
                    <div class="section"></div>
                    <div class="row">
                        <form class="col s12">
                            <div class="row">
                                <div class="input-field col s12">
                                    <input id="input-username" type="text" value={ name }>
                                    <label for="input-username" class="active">Name</label>
                                </div>
                                <div class="input-field col s12">
                                    <textarea id="input-caption" class="materialize-textarea"></textarea>
                                    <label for="input-caption">Caption</label>
                                </div>
                                <div class="input-field col s12">
                                    <div id="input-topics-chips" class="chips chips-placeholder">
                                        <input id="input-topics" class="">
                                    </div>
                                </div>
                                <div class="input-field col s12">
                                    <input type="file" id="input-file" class="dropify">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="card-action">
                    <button class="btn waves-effect waves-light" type="submit" onclick={ attemptPostCreate }>
                        <i class="material-icons left">create</i>
                        Create Post
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        import { app } from "../scripts/application";

        // Get post service
        const PostService = app.getService("post");

        this.on("mount", async function () {
            // Get settings
            var settingsResult = await PostService.getSettings();
            var settings = settingsResult.data;

            // Set caption length limit
            $("#input-caption").attr("data-length", settings.postCharacterLimit);
            $("#input-caption").characterCounter();

            // Initialize chips
            $("#input-topics-chips").chips({
                placeholder: "Enter a topic",
                secondaryPlaceholder: "+Topic"
            });

            // Initialize file input
            $("#input-file").dropify({
                maxFileSize: (settings.postImageSizeLimit / (1024 * 1024)) + "MB", // Limit in MB
                allowedFormats: ["portrait", "square", "landscape"],
                defaultFile: "",
                tpl: {
                    message: '<div class="dropify-message"><i class="material-icons">file_upload</i> <p>{{ default }}</p></div>'
                }
            });

            // Get random name
            var result = await PostService.getRandomName();
            var name = result.data;
            this.update({
                name: name
            });
        });

        this.keyDown = async (e) => {
            if (event.key === "Enter") {
                await this.attemptPostCreate();
            }
        };

        this.attemptPostCreate = async (e) => {
            // Get post details
            var name = $("#input-username").val();
            var caption = $("#input-caption").val();
            var topics = $("#input-topics-chips")[0].M_Chips.chipsData;
            var file = $("input[type=file]")[0].files[0];

            // Check if caption exists
            if (!caption.length) {
                M.toast({ html: "Invalid caption!" });
                return;
            }

            // Check if topics were specified
            if (!topics.length) {
                M.toast({ html: "Topics were not specified!" });
                return;
            }

            // Check if image was specified
            if (!file) {
                M.toast({ html: "An image must be attached!" });
                return;
            }

            var topicArray = [];
            for (var topic of topics) {
                topicArray.push(topic.tag);
            }

            try {
                // TODO: Disable post button
                var result = await PostService.create({
                    topics: topicArray, 
                    caption: caption, 
                    file: file, 
                    name: name
                });

                // TODO: Redirect!
                M.toast({ html: `Created post: ${result.data.id}` });
            } catch (error) {
                M.toast({ html: `An error occurred while trying to create post` });
                M.toast({ html: error });
            }
        };
    </script>
</create-view>

<script>
    $("#input-file-now").dropify();
</script>