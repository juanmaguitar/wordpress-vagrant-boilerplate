module.exports = function(grunt) {

	grunt.initConfig({
		baseFolder: '.',
		pkg: grunt.file.readJSON('package.json')
	});

	/* watch */
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.config('watch', {
		options: {
			livereload: '<%= connect.options.livereload %>',
		},
		all : {
			files: ['<%= baseFolder %>/**/*', '<%= baseFolder %>/*', 'Gruntfile.js']
		}
	});

	/* connect */
	grunt.loadNpmTasks('grunt-contrib-connect');
	grunt.config('connect', {
		options: {
			port: 8080,
			livereload: 35729,
			hostname: 'localhost'
		},
		livereload: {
			options: {
				open: true,
				base: '<%= baseFolder %>'
			}
		}
	});

	grunt.registerTask('serve', ['connect:livereload','watch:all']);
	grunt.registerTask('default', ['serve']);

};