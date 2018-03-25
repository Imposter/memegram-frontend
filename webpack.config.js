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
  entry: [
    // Program entrypoint
    "./src/app.ts",

    // Global materialize-css loader and configuration
    "materialize-loader!./src/libs/materialize-css/materialize.config.js"
  ],
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
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        use: [
          {
            loader: "url-loader",
            options: {
              limit: 10000,
              name: "./fonts/[hash]-[name].[ext]",
              mimetype: "application/font-woff"
            }
          }
        ]
      },
      {
        test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: "file-loader"
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
    filename: "bundle.js",
    chunkFilename: "bundle.js",
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
      { from: "./src/fonts", to: "fonts" },
      { from: "./src/views", to: "views" }
    ]),
    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: "jquery",
      riot: "riot",
      materialize: "materialize-css"
    }),
    extractStyle
  ]
};