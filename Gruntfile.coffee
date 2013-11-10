# Grunt configuration updated to latest Grunt.
module.exports = (grunt) ->

  # Initialize the configuration.
  grunt.initConfig

    aws: grunt.file.readJSON('credentials.json')

    clean:
      main:
        src: ['target/main']

      unit:
        src: ['target/test/unit']

      e2e:
        src: ['target/test/e2e']

    copy:
      main:
        files: [
          {expand: true, cwd: 'src/main/html', src: ['**'], dest: 'target/main/'}
          {expand: true, cwd: 'src/main/css',  src: ['**'], dest: 'target/main/css/'}
          {expand: true, cwd: 'src/main/img',  src: ['**'], dest: 'target/main/img/'}
          {expand: true, cwd: 'src/main/lib',  src: ['**'], dest: 'target/main/lib/'}
        ]

      unit:
        files: [
          {expand: true, cwd: 'src/test/unit/lib', src: ['**'], dest: 'target/test/unit/lib/'}
        ]

      e2e:
        files: [
          {expand: true, cwd: 'src/test/e2e/lib', src: ['**'], dest: 'target/test/e2e/lib/'}
        ]

    coffee:
      options:
        join: true

      main:
        files:
          'target/main/js/main.js': ['src/main/coffee/main.coffee', 'src/main/coffee/**/*.coffee']

      unit:
        files:
          'target/test/unit/js/test.js': ['src/test/unit/coffee/**/*.coffee']

      e2e:
        files:
          'target/test/e2e/js/test.js': ['src/test/e2e/coffee/**/*.coffee']

    coffeelint:
      options:
        'max_line_length':
          'value': 160,
          'level': 'error'

      main:
        files:
          src: ['src/main/coffee/**/*.coffee']

      unit:
        files:
          src: ['src/test/unit/coffee/**/*.coffee']

      e2e:
        files:
          src: ['src/test/e2e/coffee/**/*.coffee']

    watch:
      files: ['src/main/**/*', 'src/test/**/*']
      tasks: ['build', 'karma:dev:run']

    karma:
      options:
        frameworks: ['jasmine']
        browsers: ['Chrome']
        files: ['target/main/lib/angular.js', 'target/test/unit/lib/angular-mocks.js', 'target/main/js/**/*.js', 'target/test/unit/js/**/*.js']
      dev:
        options:
          background: true
          reporters: 'dots'
      build:
        options:
          singleRun: true

    s3:
      options:
        accessKeyId: '<%= aws.accessKeyId %>'
        secretAccessKey: '<%= aws.secretAccessKey %>'
        region: '<%= aws.region %>'
        bucket: '<%= aws.bucket %>'

      build:
        cwd: 'target/main'
        src: '**'
        dest: 'firebase/'

    connect:
      server:
        options:
          protocol: 'https'
          base: 'target/main'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-aws'


  grunt.registerTask 'default', ['dev']
  grunt.registerTask 'build', ['copy', 'coffeelint', 'coffee']
  grunt.registerTask 'dev', ['build', 'connect', 'karma:dev:start', 'watch']
  grunt.registerTask 'test', ['build', 'karma:build']
  grunt.registerTask 'deploy', ['clean', 's3']