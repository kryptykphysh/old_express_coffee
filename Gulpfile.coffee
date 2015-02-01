# Load all required libraries.
gulp       = require 'gulp'
sass       = require 'gulp-ruby-sass'
prefix     = require 'gulp-autoprefixer'
cssmin     = require 'gulp-cssmin'
jade       = require 'gulp-jade'
minifyHTML = require 'gulp-minify-html'
svgmin     = require 'gulp-svgmin'

# Create your CSS from Sass, Autoprexif it to target 99%
#  of web browsers, minifies it.
gulp.task 'css', ->
  sass('src/public/stylesheets', {
    style: 'expanded',
    sourcemap: true
  })
  .pipe prefix "> 1%"
  .pipe cssmin keepSpecialComments: 0
  .pipe gulp.dest 'lib/public/stylesheets'

# Create you HTML from Jade, Adds an additional step of
#  minification for filters (like markdown) that are not
#  minified by Jade.
gulp.task 'html', ->
  gulp.src 'src/**/*.jade'
    .pipe jade()
    .pipe minifyHTML()
    .pipe gulp.dest 'lib'

# Minify your SVG.
gulp.task 'svg', ->
  gulp.src 'src/public/images/*.svg'
    .pipe svgmin()
    .pipe gulp.dest 'lib/public/images/'

# Copy the fonts using streams.
gulp.task 'copy', ->
  gulp.src 'src/public/fonts/*'
    .pipe gulp.dest 'lib/public/fonts'

# Default task call every tasks created so far.
gulp.task 'default', ['css', 'html', 'svg', 'copy']
