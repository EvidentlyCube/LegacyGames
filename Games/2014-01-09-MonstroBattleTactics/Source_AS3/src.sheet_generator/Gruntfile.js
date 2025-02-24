module.exports = function (grunt) {
    var path = __dirname;

    require('load-grunt-tasks')(grunt);

    var atlasGeneratorTemplater = function (params) {
        var json = {};
        var frames = [];

        params.items.forEach(function (item) {
            frames.push({
                filename: item.name,
                frame: {
                    x: item.x + item.extend,
                    y: item.y + item.extend,
                    w: item.width - item.extend * 2,
                    h: item.height - item.extend * 2
                },
                rotated: false,
                trimmed: false
            });
        });

        json.frames = frames;

        return JSON.stringify(json, null, 4);
    };

    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        sprite: {
            gui: {
                src: path + '/../assets/sheet_src/gui/*.png',
                dest: path + '/../assets/sheets/gui.png',
                destCss: path + '/../assets/sheets/gui.json',
                cssTemplate: atlasGeneratorTemplater,
                extend: 1
            },
            map: {
                src: path + '/../assets/sheet_src/map/*.png',
                dest: path + '/../assets/sheets/map.png',
                destCss: path + '/../assets/sheets/map.json',
                cssTemplate: atlasGeneratorTemplater,
                extend: 1
            },
	        achievements: {
                src: path + '/../assets/sheet_src/achievements/*.png',
                dest: path + '/../assets/sheets/achievements.png',
                destCss: path + '/../assets/sheets/achievements.json',
                cssTemplate: atlasGeneratorTemplater,
                extend: 1
            }
        }
    });

    // Default task(s).
    grunt.registerTask('default', [
        'sprite:gui',
        'sprite:map',
        'sprite:achievements'
    ]);
};