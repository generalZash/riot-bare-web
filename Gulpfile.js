var gulp         = require('gulp');
var sass         = require('gulp-sass');
var browserSync  = require('browser-sync').create();
var riot         = require('gulp-riot');
var util         = require('gulp-util');
var jshint       = require('gulp-jshint');
var autoprefixer = require('gulp-autoprefixer');

// Standard handler
function standardHandler(err){
  // Log to console
  util.log(util.colors.red('Error'), err.message);
}

// Static server & watch scss/html
gulp.task('serve', ['sass'], function() {
  browserSync.init({
    server: {
      baseDir: './',
      index: './index.html'
    }
  });

  gulp.watch('scss/*.scss', ['sass']);
  gulp.watch('index.html').on('change', browserSync.reload);
  gulp.watch('src/*.tag', ['riot']);
  gulp.watch('src/*.js', ['lint']);
});

// Compile sass into CSS & inject into browsers
// not sure how this works so go check out www.browsersync.io
gulp.task('sass', function () {
  return gulp.src('scss/*.scss')
    .pipe(sass({
      errLogToConsole: true
    }))
    .on('error', standardHandler)
    .pipe(autoprefixer({
      bfowsers: ['last 2 versions']
    }))
    .pipe(gulp.dest('app/css/'))
    .pipe(browserSync.stream());
});

// Compile riot *.tag files to javascript
gulp.task('riot', function() {
  return gulp.src('src/*.tag')
    .pipe(riot())
    .on('error', standardHandler)
    .pipe(gulp.dest('app/js/'))
    .pipe(browserSync.stream());
});

// Lint js
gulp.task('lint', function() {
  return gulp.src('src/*.js')
    .pipe(jshint())
    .pipe(jshint.reporter('default'))
    .pipe(gulp.dest('app/js/'))
    .pipe(browserSync.stream());
});

gulp.task('default', ['serve']);