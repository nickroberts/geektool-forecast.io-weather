module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    jshint: {
      all: ['*.js']
    },
    watch: {
      scripts: {
        files: ['*.js'],
        tasks: ['jshint']
      }
    },
  });

  // Load the plugins that provide the tasks.
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-watch');

  // register the tasks
  grunt.registerTask('default', ['jshint']);

};
