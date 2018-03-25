const path = require("path");
const webpack = require("webpack");
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");

const extractStyle = new ExtractTextPlugin({
  filename: "./css/style.css",
  disable: process.env.NODE_ENV === "development"
});

module.exports = {
  entry: "./src/app.ts",
  devtool: "inline-source-map",
  mode: "development",
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: ["ts-loader"],
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
                minimize: true,
                sourceMap: true
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
        exclude: /node_modules/,
        use: [
          {
            loader: "riot-tag-loader",
            query: {
              type: "es6",
              hot: true
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
    filename: "source.js",
    path: path.resolve(__dirname + "/dist/")
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: "Memegram",
      template: "./index.html"
    }),
    new CopyWebpackPlugin([
      { from: "./src/scripts", to: "scripts", ignore: ["*.ts"] },
      { from: "./src/css", to: "css", ignore: ["*.scss"] },
      { from: "./src/images", to: "images" },
      { from: "./src/views", to: "views" }
    ]),
    new webpack.ProvidePlugin({
      riot: "riot"
    }),
    extractStyle
  ]
};