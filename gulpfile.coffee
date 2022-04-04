gulp = require 'gulp'
gulpCoffee = require 'gulp-coffee'
gulpPug = require 'gulp-pug'
gulpChmod = require 'gulp-chmod'
gulpGhPages = require 'gulp-gh-pages'

## npm run build / npx gulp pug: builds index.html from index.pug etc.
exports.pug = pug = ->
  gulp.src 'index.pug'
  .pipe gulpPug pretty: false # true adds extra spaces :-(
  .pipe gulpChmod 0o644
  .pipe gulp.dest './'

## npx gulp coffee: builds *.js from *.coffee
exports.coffee = coffee = ->
  gulp.src '*.coffee', ignore: 'gulpfile.coffee'
  .pipe gulpCoffee()
  .pipe gulpChmod 0o644
  .pipe gulp.dest './'

## npm run watch / npx gulp watch: continuously update index.html from deps
exports.watch = watch = ->
  gulp.watch '*.pug', ignoreInitial: false, pug
  gulp.watch '*.styl', pug
  ## For coffee inlined into pug:
  #gulp.watch '*.coffee', ignored: 'gulpfile.coffee', pug
  ## For coffee built separated into js:
  gulp.watch '*.coffee',
    ignored: 'gulpfile.coffee'
    ignoreInitial: false
  , coffee

deploySet = [
  './.nojekyll'
  './index.html'
  # Add images etc. in ./ to this list
  './node_modules/reveal.js/dist/reveal.js'
  './node_modules/reveal.js-plugins/chalkboard/plugin.js'
  './node_modules/reveal.js/dist/reveal.css'
  './node_modules/reveal.js/dist/theme/black.css'
  './node_modules/reveal.js-plugins/chalkboard/style.css'
  './node_modules/reveal.js-plugins/chalkboard/img/sponge.png'
  './node_modules/reveal.js-plugins/chalkboard/img/boardmarker-*.png'
  './node_modules/reveal.js-plugins/chalkboard/img/blackboard.png'
  './node_modules/reveal.js-plugins/menu/font-awesome/css/all.css'
  './node_modules/reveal.js-plugins/menu/font-awesome/webfonts/fa-solid-900.woff2'
  './node_modules/katex/dist/katex.min.js'
  './node_modules/katex/dist/contrib/auto-render.min.js'
  './node_modules/katex/dist/fonts/*.woff2'
  './node_modules/katex/dist/katex.css'
  './node_modules/@svgdotjs/svg.js/dist/svg.min.js'
  './node_modules/svgtiler/lib/svgtiler.js'
  './node_modules/@fontsource/merriweather/latin-400.css'
  './node_modules/@fontsource/merriweather/latin-400-italic.css'
  './node_modules/@fontsource/merriweather/latin-900.css'
  './node_modules/@fontsource/merriweather/latin-900-italic.css'
  './node_modules/@fontsource/merriweather/files/merriweather-latin-400-normal.woff2'
  './node_modules/@fontsource/merriweather/files/merriweather-latin-400-italic.woff2'
  './node_modules/@fontsource/merriweather/files/merriweather-latin-900-normal.woff2'
  './node_modules/@fontsource/merriweather/files/merriweather-latin-900-italic.woff2'
]

## npm run build / npx gulp: build index.html and *.coffee
exports.build = exports.default = build = gulp.parallel pug, coffee

## npm run dist / npx gulp dist: copy just needed files to `dist` directory
## (for testing before deploy)
exports.dist = dist = gulp.series build, copy = ->
  gulp.src deploySet, base: './'
  .pipe gulp.dest './dist/',
    mode: 0o644
    dirMode: 0o755

## npm run deploy / npx gulp deploy: deploy needed files to `gh-pages` branch
## (thereby deploying to GitHub Pages)
exports.deploy = deploy = gulp.series dist, deploy = ->
  gulp.src deploySet, base: './'
  .pipe gulpGhPages()

exports.default = pug
