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
  gulp.src 'app/css/index.sass'
    .pipe sass()
    .pipe prefix "> 1%"
    .pipe cssmin keepSpecialComments: 0
    .pipe gulp.dest 'www/css'

# Create you HTML from Jade, Adds an additional step of
#  minification for filters (like markdown) that are not
#  minified by Jade.
gulp.task 'html', ->
  gulp.src 'app/index.jade'
    .pipe jade()
    .pipe minifyHTML()
    .pipe gulp.dest 'www'

# Minify your SVG.
gulp.task 'svg', ->
  gulp.src 'app/img/*.svg'
    .pipe svgmin()
    .pipe gulp.dest 'www/img'

# Copy the fonts using streams.
gulp.task 'copy', ->
  gulp.src 'app/fonts/*'
    .pipe gulp.dest 'www/fonts'

# Default task call every tasks created so far.
gulp.task 'default', ['css', 'html', 'svg', 'copy']
