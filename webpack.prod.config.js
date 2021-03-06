const webpack = require("webpack");
const merge = require("webpack-merge");
const config = require("./webpack.base.config.js");

module.exports = merge(config, {
    mode: "production",
    devtool: "source-map",
    plugins: [
        new webpack.EnvironmentPlugin({
            API_URL: "https://mg.indigogames.ca/api/"
        })
    ]
});