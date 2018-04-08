// Babel Polyfill
import "babel-polyfill";

// RiotJS
import * as riot from "riot";
import route from "riot-route";

// jQuery
global.$ = require("jquery");
global.jQuery = require("jquery");

// jQuery Lazy Load
require("jquery-lazy/jquery.lazy.js");

// jQuery LazyLoadXT
require("lazyloadxt/dist/jquery.lazyloadxt.js"); // TODO: Replace with Lazy Load

// Materialize CSS (Runtime)
require("materialize-css/dist/js/materialize.js");

// Dropify
require("dropify/dist/js/dropify.js");

// Stylesheets
import "./css/style.scss";

// Scripts/Libraries
import { createApp } from "./scripts/application";
import { Service } from "./scripts/service";
import { PostService } from "./scripts/services/post-service";

// Views (Runtime)
require("./app.tag");
require("./views/post.tag");
require("./views/display.tag");
require("./views/create.tag");

// Configure server
Service.serverUrl = "http://localhost:12400/api/";

// Create app
const app = createApp({
    name: "Memegram",
    date: new Date(),
    options: {
        postFetchLimit: 10
    },

    targetView: "#app-body",
    availableViews: [ "post", "display", "create" ],
    defaultView: "display",

    services: [
        new PostService()
    ]
});

// Mount app
var root = riot.mount("*", { app: app })[0];

// Begin routing
app.initialize(root);