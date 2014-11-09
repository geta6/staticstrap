'use strict'

jit = require 'jit-grunt'

module.exports = (grunt) ->

  jit grunt

  isProduction = process.env.NODE_ENV is 'production'

  grunt.registerTask 'js', [ 'coffee', 'coffeelint' ]
  grunt.registerTask 'css', [ 'stylus', 'csslint' ]
  grunt.registerTask 'html', [ 'jade' ]
  grunt.registerTask 'configure', [ 'clean', 'copy', 'js', 'css', 'html' ]

  grunt.registerTask 'build', [ 'configure', 'requirejs' ]
  grunt.registerTask 'debug', [ 'configure', 'connect', 'watch' ]

  grunt.registerTask 'default', [ 'debug' ]

  grunt.initConfig
    clean:
      site: files: [{
        expand: true
        src: ['public/*', '!public/vendor']
      }]

    copy:
      site:
        files: [{
          expand: yes
          cwd: 'assets'
          src: ['*', '**/*', '!**/*.{jade,coffee,styl}']
          dest: 'public'
          filter: 'isFile'
        }]

    coffee:
      site:
        options:
          sourceMap: yes
        files: [{
          expand: yes
          cwd: 'assets'
          src: [ '*.coffee', '**/*.coffee' ]
          dest: 'public'
          filter: 'isFile'
          ext: '.js'
        }]

    stylus:
      site:
        options:
          compress: isProduction
          'include css': true
        files:
          'public/application.css': ['assets/config.styl']

    jade:
      options:
        pretty: !isProduction
      site:
        files: [{
          expand: yes
          cwd: 'assets'
          src: [ '*.jade', '**/*.jade' ]
          dest: 'public'
          filter: 'isFile'
          ext: '.html'
        }]

    requirejs:
      site:
        options:
          baseUrl: 'public/javascripts'
          mainConfigFile: 'public/config.js'
          out: 'public/application.js'
          include: [ '../config' ]
          optimize: 'uglify2'
          wrap: yes
          name: '../vendor/almond/almond'
          skipModuleInsertion: no
          generateSourceMaps: yes
          preserveLicenseComments: no

    csslint:
      site:
        options:
          csslintrc: './config/csslintrc.json'
        src: ['public/application.css' ]

    coffeelint:
      options:
        coffeelintrc: './config/coffeelintrc.json'
      site:
        files: [{
          expand: yes
          cwd: 'assets'
          src: [ '*.coffee', '**/*.coffee' ]
          filter: 'isFile'
        }]

    connect:
      site:
        options:
          hostname: '*'
          port: process.env.PORT or 3000
          base: 'public'

    watch:
      options:
        livereload: yes
        interrupt: yes
        spawn: no
      static:
        tasks: ['copy']
        files: ['assets/*', 'assets/**/*', '!assets/*.{coffee,styl,jade}', '!assets/**/*.{coffee,styl,jade}']
      js:
        tasks: ['js']
        files: ['assets/*.coffee', 'assets/**/*.coffee']
      css:
        tasks: ['css']
        files: ['assets/*.styl', 'assets/**/*.styl']
      html:
        tasks: ['html']
        files: ['assets/*.jade', 'assets/**/*.jade']
