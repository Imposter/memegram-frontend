const webpack = require("webpack");
const merge = require("webpack-merge");
const config = require("./webpack.base.config.js");

module.exports = merge(config, {
    plugins: [
        new webpack.EnvironmentPlugin({
            API_URL: "http://localhost:12400/api/"
        })
    ]
});