// Babel Polyfill
import "babel-polyfill";

// RiotJS
import * as riot from "riot";
import route from "riot-route";

// jQuery
global.$ = require("jquery");
global.jQuery = require("jquery");

// Javascript TimeAgo
global.timeago = require("timeago.js");

// jQuery Lazy Load
require("jquery-lazy/jquery.lazy.js");

// jQuery LazyLoadXT
require("lazyloadxt/dist/jquery.lazyloadxt.js"); // TODO: Replace with Lazy Load

// Materialize CSS (Runtime)
require("materialize-css/dist/js/materialize.js");

// Dropify
require("dropify/dist/js/dropify.js");

// Avatars
require("./scripts/avatar.js");

// Stylesheets
import "./css/style.scss";

// Scripts/Libraries
import { createApp } from "./scripts/application";
import { Service } from "./scripts/service";
import { PostService } from "./scripts/services/post-service";
import { CommentService } from "./scripts/services/comment-service";

// Views (Runtime)
require("./app.tag");
require("./views/post.tag");
require("./views/display.tag");
require("./views/create.tag");

// Configure server
Service.serverUrl = "http://localhost:12400/api/";
Service.timeout = 2500; // ms

// Create app
const app = createApp({
    name: "Memegram",
    date: new Date(),
    options: {    
        postFetchLimit: 10,
        commentFetchLimit: 20,
        scrollLoadY: 10, 
    },

    targetView: "#app-body",
    availableViews: [ "post", "display", "create" ],
    defaultView: "display",

    services: [
        new PostService(),
        new CommentService()
    ]
});

// Mount app
var root = riot.mount("*", { app: app })[0];

// Begin routing
app.initialize(root);