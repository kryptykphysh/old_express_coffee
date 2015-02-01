# Load all required libraries.
gulp        = require 'gulp'
sass        = require 'gulp-ruby-sass'
prefix      = require 'gulp-autoprefixer'
sourcemaps  = require 'gulp-sourcemaps'
coffee      = require 'gulp-coffee'
cssmin      = require 'gulp-cssmin'
jade        = require 'gulp-jade'
minifyHTML  = require 'gulp-minify-html'
svgmin      = require 'gulp-svgmin'
coffee-lint = require 'gulp-coffeelint'
nodemon     = require 'gulp-nodemon'

# Create your CSS from Sass, Autoprexif it to target 99%
#  of web browsers, minifies it.
gulp.task 'css', ->
  gulp.src('./src/public/stylesheets/**/*', {
    style: 'expanded',
    sourcemap: true
  })
    .pipe prefix "> 1%"
    .pipe cssmin keepSpecialComments: 0
    .pipe gulp.dest './lib/public/stylesheets/'

# Compile CoffeeScript to JS.
gulp.task 'coffee', ->
  gulp.src './src/**/*.coffee'
    .pipe sourcemaps.init()
    .pipe coffee()
    .pipe sourcemaps.write()
    .pipe gulp.dest './lib/'

# Lint CoffeeScript in src
gulp.task 'coffee-lint', ->
  gulp.src './src/**/*.coffee'
    .pipe coffeelint()
    .pipe coffeelint.reporter()

# Start server and restart on file changes
gulp.task 'develop', ->
  nodemon({
    script: './lib/server.js',
    ext:    'coffee jade svg scss',
    env:    { 'NODE_ENV': 'development' }
  })
    .on 'change', ['coffee-lint', 'coffee', 'css', 'html', 'svg']
    .on 'restart', ->
      console.log 'restarted'

# Create you HTML from Jade, Adds an additional step of
#  minification for filters (like markdown) that are not
#  minified by Jade.
gulp.task 'html', ->
  gulp.src 'src/**/*.jade'
    .pipe jade()
    .pipe minifyHTML()
    .pipe gulp.dest 'lib/'

# Minify your SVG.
gulp.task 'svg', ->
  gulp.src 'src/public/images/**/*.svg'
    .pipe svgmin()
    .pipe gulp.dest 'lib/public/images/'

# Copy the fonts using streams.
gulp.task 'copy', ->
  gulp.src 'src/public/fonts/**/*'
    .pipe gulp.dest 'lib/public/fonts/'

# Default task call every tasks created so far.
gulp.task 'default', ['css', 'html', 'svg', 'coffee', 'copy', 'develop']
