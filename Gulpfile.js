var gulp         = require('gulp');
var sass         = require('gulp-sass');
var browserSync  = require('browser-sync').create();
var riot         = require('gulp-riot');
var Notification = require('node-notifier');
var util         = require('gulp-util');

// Standard handler
function standardHandler(err){
  // Notification
  var notifier = Notification();
  notifier.notify({ message: 'Error: ' + err.message });
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
  gulp.watch('app/index.html').on('change', browserSync.reload);
  gulp.watch('src/*.tag', ['riot']);
})

// Compile sass into CSS & inject into browsers
// not sure how this works so go check out www.browsersync.io
gulp.task('sass', function () {
  return gulp.src('scss/*.scss')
    .pipe(sass({
      errLogToConsole: true
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

gulp.task('dev', ['serve']);