<!--Fill in the following with your talk details (if desired).

# Talk:

This repository contains slides for our talk...

## [View Slides](https://...github.io/)

[![Title slide](title_slide.jpg)](https://...github.io/)
-->

## Technology: RevealJS + Pug + [Stylus] + [CoffeeScript] + [KaTeX] + [SVG.js]

This repository uses the
[reveal-pug-talk template](https://github.com/edemaine/reveal-pug-talk)
to slides by combining the following technology (all free and open source):

* [RevealJS](https://revealjs.com/): a flexible HTML presentation framework,
  extendable by plugins and themes.  Here we use:
  * [Chalkboard](https://github.com/rajgoel/reveal.js-plugins/tree/master/chalkboard):
    enables live drawing annotation on the slides (using pen or touch or mouse)
  * [Merriweather](https://fonts.google.com/specimen/Merriweather) font
* [Pug](https://pugjs.org/): a concise indentation-based notation for HTML,
  which makes it easier to express RevealJS slides,
  and to mix together other languages.  Here we use:
  * [Stylus](https://stylus-lang.com/): a concise indentation-based notation
    for CSS (styling of HTML)
  * [CoffeeScript](https://coffeescript.org/): an indentation-based language
    that compiles to JavaScript
* [KaTeX](https://katex.org): a library for translating LaTeX math into HTML
* [SVG.js](https://svgdotjs.github.io/):
  a library that makes it easy to add animations to SVG drawings
* [Gulp](https://gulpjs.com/): a tool that builds the Pug code into HTML

## Structure

Here's an overview of the individual files and what they do:

* [`gulpfile.coffee`](gulpfile.coffee): Definitions of `build` and `watch`
  rules that run Pug on `index.pug`.
* [`index.pug`](index.pug): Top-level Pug file that calls all other files.
  Defines the top-level structure of the document, but has no slides.
* [`slides.pug`](slides.pug): Slides and specific animations are defined here.
* [`index.styl`](index.styl): Custom RevealJS styling,
  and any specific styling for the slides.

<!-- Add any .coffee, images, etc. files here, if desired -->

## Build Instructions

To build the slides HTML (`index.html`) from the source files:

1. Install [NodeJS](https://nodejs.org/) if you haven't already.
2. Clone the repository
3. Run the following:

   ```sh
   npm install
   npm run build
   ```

If you're live-editing the file and want `index.html` to continually build
and update, use the following command:

```sh
npm run watch
```

To assemble just the needed files into a `dist` directory,
use the following command:

```sh
npm run dist
```

To deploy these files to GitHub Pages, use the following command:

```sh
npm run deploy
```
