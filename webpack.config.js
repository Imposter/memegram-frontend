const path = require("path");
const webpack = require("webpack");
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");

const development = process.env.NODE_ENV === "development";
const extractStyle = new ExtractTextPlugin({
	filename: "./css/style.css",
	disable: development
});

module.exports = {
	entry: [
		// Babel Polyfill
		"babel-polyfill",

		// Program entrypoint
		"./src/app.js"
	],
	devtool: "inline-source-map",
	mode: "development",
	module: {
		rules: [
			{
				test: /\.ts(x?)$/,
				use: [
					{
						loader: "babel-loader",
						options: {
							presets: ["babel-preset-es2015-riot", "babel-preset-env"]
						}
					},
					{ loader: "ts-loader" }
				],
				exclude: /node_modules/
			},
			{
				test: /\.css$/,
				use: extractStyle.extract({
					use: "css-loader",
					fallback: "style-loader"
				})
			},
			{
				test: /\.scss$/,
				use: extractStyle.extract({
					use: [
						{
							loader: "css-loader",
							options: {
								url: false,
								minimize: !development,
								sourceMap: true,
							}
						},
						{
							loader: "sass-loader",
							options: {
								sourceMap: true
							}
						}
					]
				})
			},
			{
				test: /\.(png|jp(e*)g|svg)$/,
				use: [
					{
						loader: "url-loader",
						options: {
							limit: 8000, // Convert images < 8kb to base64 strings
							name: "images/[hash]-[name].[ext]"
						}
					},
					{
						loader: "file-loader",
						options: {}
					}
				]
			},
			{
				test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
				use: [
					{
						loader: "url-loader",
						options: {
							limit: 10000,
							name: "fonts/[hash]-[name].[ext]",
							mimetype: "application/font-woff"
						}
					}
				]
			},
			{
				test: /\.tag$/,
				exclude: /node_modules/,
				use: [
					{
						loader: "riot-tag-loader",
						query: {
							type: "es6",
							hot: false
						}
					}
				]
			}
		]
	},
	resolve: {
		extensions: [".tsx", ".ts", ".js"]
	},
	output: {
		filename: "[name].js",
		chunkFilename: "[chunkhash].js",
		path: path.resolve(__dirname + "/dist/")
	},
	plugins: [
		new HtmlWebpackPlugin({
			title: "Memegram",
			template: "./src/index.html"
		}),
		new CopyWebpackPlugin([
			{ from: "./src/scripts", to: "scripts", ignore: ["*.ts"] },
			{ from: "./src/css", to: "css", ignore: ["*.scss"] },
			{ from: "./src/images", to: "images", ignore: ["*.psd"] },
			{ from: "./src/views", to: "views" }
		]),
		new webpack.ProvidePlugin({
			$: "jquery",
			jQuery: "jquery",
			riot: "riot",
			route: "riot-route"
		}),
		extractStyle
	]
};