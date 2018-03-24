const webpack = require("webpack");
const config = require("./webpack.config.js");

config.mode = "production";
config.devtool = "eval";
config.plugins.push(new webpack.optimize.UglifyJsPlugin({
    output: { comments: false },
    exclude: [/\.min\.js$/gi] // Skip minified
}));

module.exports = config;