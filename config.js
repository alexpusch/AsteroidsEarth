requirejs.config({
    baseUrl: '.tmp/scripts',
    paths: {
      'pixi': '../../app/bower_components/pixi/bin/pixi.dev'
    },
    shim: { 
      'pixi': { 
         deps: [],
         exports: 'PIXI'
       }
    }
});