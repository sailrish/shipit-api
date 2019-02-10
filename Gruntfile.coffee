module.exports = (grunt) =>

  grunt.initConfig
    clean:
      build: ['target/*']

    coffee:
      compile:
        files: [
          {expand: true, cwd: 'src', src: '**/*.coffee', dest: 'target', ext: '.js'}
        ]

    foreman:
      dev:
        env: ['development.env']

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-foreman'

  grunt.registerTask 'default', [
    'clean', 'coffee:compile'
  ]

  grunt.registerTask 'dev', [
    'clean', 'coffee:compile', 'foreman'
  ]
