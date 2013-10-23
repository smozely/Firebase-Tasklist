# Grunt configuration updated to latest Grunt.
module.exports = (grunt) ->

  # Initialize the configuration.
  grunt.initConfig

    aws: grunt.file.readJSON("credentials.json")

    clean:
      main:
        src: ['target/main']

    copy:
      main:
        files: [
          {expand: true, cwd: 'src/main/html', src: ['**'], dest: 'target/main/'}
        ]

    watch:
      files: ['src/main/**/*']
      tasks: ['copy']

    s3:
      options:
        accessKeyId: "<%= aws.accessKeyId %>"
        secretAccessKey: "<%= aws.secretAccessKey %>"
        region: "<%= aws.region %>"
        bucket: "<%= aws.bucket %>"

      build:
        cwd: "target/main"
        src: "**"
        dest: "firebase/"

    connect:
      server:
        options:
          protocol: 'https'
          base: 'target/main'

  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-aws"

  grunt.registerTask "run", ["clean", "copy", "connect:server", "watch"]
  grunt.registerTask "deploy", ["clean", "copy", "s3"]