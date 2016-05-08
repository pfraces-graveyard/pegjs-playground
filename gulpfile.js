var gulp = require('gulp');
var del = require('del');
var pegjs = require('gulp-pegjs');
var wrapper = require('gulp-wrapper');

gulp.task('clean', function () {
  return del(['dist']);
});

gulp.task('build', ['clean'], function () {
  return gulp.src('src/**/*.pegjs')
    .pipe(pegjs())
    .pipe(wrapper({
      header: 'module.exports = '
    }))
    .pipe(gulp.dest('dist'));
});
