gulp = require 'gulp'
gulpPug = require 'gulp-pug'
gulpChmod = require 'gulp-chmod'
gulpGhPages = require 'gulp-gh-pages'

## npm run build / npx gulp pug: builds index.html from index.pug etc.
exports.pug = pug = ->
  gulp.src 'index.pug'
  .pipe gulpPug pretty: true
  .pipe gulpChmod 0o644
  .pipe gulp.dest './'

## npm run watch / npx gulp watch: continuously update index.html from deps
exports.watch = watch = ->
  gulp.watch '*.pug', pug
  gulp.watch '*.styl', pug
  gulp.watch '*.coffee', pug

deploySet = [
  './.nojekyll'
  './index.html'
  './cayley4.png'
  './node_modules/reveal.js/dist/reveal.js'
  './node_modules/reveal.js-plugins/chalkboard/plugin.js'
  './node_modules/@svgdotjs/svg.js/dist/svg.min.js'
  './node_modules/katex/dist/katex.min.js'
  './node_modules/katex/dist/contrib/auto-render.min.js'
  './node_modules/katex/dist/fonts/*.woff2'
  './node_modules/reveal.js/dist/reveal.css'
  './node_modules/reveal.js/dist/theme/black.css'
  './node_modules/reveal.js-plugins/chalkboard/style.css'
  './node_modules/reveal.js-plugins/chalkboard/img/sponge.png'
  './node_modules/reveal.js-plugins/chalkboard/img/boardmarker-*.png'
  './node_modules/reveal.js-plugins/chalkboard/img/blackboard.png'
  './node_modules/reveal.js-plugins/menu/font-awesome/css/all.css'
  './node_modules/reveal.js-plugins/menu/font-awesome/webfonts/fa-solid-900.woff2'
  './node_modules/katex/dist/katex.css'
  './node_modules/@fontsource/merriweather/latin-400.css'
  './node_modules/@fontsource/merriweather/latin-400-italic.css'
  './node_modules/@fontsource/merriweather/latin-900.css'
  './node_modules/@fontsource/merriweather/latin-900-italic.css'
  './node_modules/@fontsource/merriweather/files/merriweather-latin-400-normal.woff2'
  './node_modules/@fontsource/merriweather/files/merriweather-latin-400-italic.woff2'
  './node_modules/@fontsource/merriweather/files/merriweather-latin-900-normal.woff2'
  './node_modules/@fontsource/merriweather/files/merriweather-latin-900-italic.woff2'
]

## npm run dist / npx gulp dist: copy just needed files to `dist` directory
## (for testing before deploy)
exports.dist = gulp.series pug, copy = ->
  gulp.src deploySet, base: './'
  .pipe gulp.dest './dist/',
    mode: 0o644
    dirMode: 0o755

## npm run deploy / npx gulp deploy: deploy needed files to `gh-pages` branch
## (thereby deploying to GitHub Pages)
exports.deploy = gulp.series pug, deploy = ->
  gulp.src deploySet, base: './'
  .pipe gulpGhPages()

exports.default = pug
