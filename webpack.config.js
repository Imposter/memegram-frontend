const path = require("path");
const webpack = require("webpack");
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = {
  entry: "./src/app.ts",
  devtool: "inline-source-map",
  mode: "development", // NOTE: This must be production when building for a production environment
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: "ts-loader",
        exclude: /node_modules/
      },
      {
        test: /\.css$/,
        use: [
          {
            loader: "style-loader" // creates style nodes from JS strings
          },
          {
            loader: "css-loader" // translates CSS into CommonJS
          },
          {
            loader: "sass-loader" // compiles Sass to CSS
          }
        ]
      },
      {
        test: /\.(png|jp(e*)g|svg)$/,
        use: [
          {
            loader: "url-loader",
            options: {
              limit: 8000, // Convert images < 8kb to base64 strings
              name: "./images/[hash]-[name].[ext]"
            }
          },
          {
            loader: "file-loader",
            options: {}
          }
        ]
      },
      {
        test: /\.tag$/, 
        exclude: [ /node_modules/ ], 
        loader: "riotjs-loader", 
        query: { 
          type: "none" 
        }
      }
    ]
  },
  resolve: {
    extensions: [".tsx", ".ts", ".js"]
  },
  output: {
    filename: "source.js",
    path: path.resolve(__dirname + "/dist/")
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: "Memegram",
      template: "./index.html"
    }),
    new CopyWebpackPlugin([
      { from: "./src/css", to: "css" },
      { from: "./src/images", to: "images" },
      { from: "./src/views", to: "views" }
    ]),
    new webpack.ProvidePlugin({
      riot: "riot"
    }),
  ],
  watch: true
};