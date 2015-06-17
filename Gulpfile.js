var gulp        = require('gulp');
var sass        = require('gulp-sass');
var browserSync = require('browser-sync').create();

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

gulp.task('dev', ['serve']);