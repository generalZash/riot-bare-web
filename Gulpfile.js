var gulp = require('gulp');
var sass = require('gulp-sass');

gulp.task('styles', function () {
  gulp.src('sass/**/*.scss')
    .pipe(sass({
      errLogToConsole: true
    }))
    .pipe(gulp.dest('./css/'));
});

gulp.task('watch', function() {
  gulp.watch('sass/**/*.scss', ['styles']);
});