path = require \path
webpack = require \webpack
HtmlPlugin = require \html-plugin
public-path = path.join __dirname, \www
env = if process.argv.slice 1 .join ' ' .includes \webpack-dev-server
  \development
else \production

style-loaders = <[css-loader sass-loader]>map ->
  loader: it, options: source-map: true minimize: env == \production

base =
  entry: \./src/index.ls
  module:
    rules:
      * test: /\.(ls|jsx|js)$/
        exclude: /node_modules/
        use: loader: \babel-loader options: require \./.babelrc
      * test: /\.sass$/
        use: if env != \production then [\style-loader]concat style-loaders
        else
          * * loader: \file-loader options: name: '[name].css'
            \extract-loader
            ...style-loaders
  resolve: extensions: <[.ls .jsx .js .sass]>

require \./register <| {}
html-options =
  title: \Template content: require \./src/render-static .default
  theme-color: try require \./www/manifest.json .theme_color

base-plugins =
  new webpack.NamedModulesPlugin
  new HtmlPlugin html-options

start-list = [\/ \/?utm_source=homescreen]
function include-start
  {revision} = it.find -> /index\.html/test it.url
  start-list.map (-> {url: it, revision}) .concat it

env-options =
  development: ->
    devtool: \cheap-module-eval-source-map
    plugins:
      ...base-plugins
      new webpack.HotModuleReplacementPlugin
    dev-server:
      content-base: public-path
      hot: true
      history-api-fallback: true
      host: \0.0.0.0

  production: ->
    MinifyPlugin = require \babel-minify-webpack-plugin
    WorkboxPlugin = require \workbox-webpack-plugin
    rewrites =
      \process.env.NODE_ENV : \'production'
      \module.hot : \false

    entry:
      main: \./src/index.ls
      vendor: \./src/vendor.ls
    output:
      path: public-path
      filename: '[name].js'
    plugins:
      new webpack.DefinePlugin rewrites
      new webpack.optimize.CommonsChunkPlugin name: \vendor min-chunks: Infinity
      new webpack.optimize.CommonsChunkPlugin name: \runtime
      ...base-plugins
      new WorkboxPlugin options =
        sw-dest: "#public-path/sw.js"
        navigate-fallback: \/
        glob-patterns: ['**\/*']
        glob-ignores: '**\/*.map'
        manifest-transforms: [include-start]
      new MinifyPlugin

export Object.assign {} base, env-options[env]!
