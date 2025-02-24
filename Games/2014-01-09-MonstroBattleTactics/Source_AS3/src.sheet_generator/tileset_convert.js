var fs = require('fs'),
    PNG = require('pngjs').PNG;

	console.log("Converting tilesets...");

var MARK_TILE_ALPHA = 190;

fs.createReadStream('../assets/sheet_src/tilesets/tile_marks.png')
	.pipe(new PNG({
		filterType: 4
	}))
	.on('parsed', function() {
		var marksData = this.data;
		var marksWidth = this.width;
		var marksHeight = this.height;

		fs.createReadStream('../assets/sheet_src/tilesets/tileset_greenland.png')
			.pipe(new PNG({
				filterType: 4
			}))
			.on('parsed', function() {
				copyMarks(this.data, marksData, this.width, marksWidth, marksHeight, MARK_TILE_ALPHA);
				for (var x = 0; x < 30; x++) {
					for (var y = 0; y < 30; y++) {
						parseTile(this.data, this.width, x, y);
					}
				}

				this.pack().pipe(fs.createWriteStream('../assets/sheets/tileset_greenland.png'));
			});

		fs.createReadStream('../assets/sheet_src/tilesets/tileset_ice.png')
			.pipe(new PNG({
				filterType: 4
			}))
			.on('parsed', function() {
				copyMarks(this.data, marksData, this.width, marksWidth, marksHeight, MARK_TILE_ALPHA);
				for (var x = 0; x < 30; x++) {
					for (var y = 0; y < 30; y++) {
						parseTile(this.data, this.width, x, y);
					}
				}

				this.pack().pipe(fs.createWriteStream('../assets/sheets/tileset_ice.png'));
			});

		fs.createReadStream('../assets/sheet_src/tilesets/tileset_lava.png')
			.pipe(new PNG({
				filterType: 4
			}))
			.on('parsed', function() {
				copyMarks(this.data, marksData, this.width, marksWidth, marksHeight, MARK_TILE_ALPHA);
				for (var x = 0; x < 30; x++) {
					for (var y = 0; y < 30; y++) {
						parseTile(this.data, this.width, x, y);
					}
				}

				this.pack().pipe(fs.createWriteStream('../assets/sheets/tileset_lava.png'));
			});
	});


function parseTile(data, imageWidth, tileX, tileY){
	var x = tileX * 34;
	var y = tileY * 34;
	var i;

	setPixel(data, data, imageWidth, x + 1, y + 1, x, y);
	setPixel(data, data, imageWidth, x + 32, y + 1, x + 33, y);
	setPixel(data, data, imageWidth, x + 1, y + 32, x, y + 33);
	setPixel(data, data, imageWidth, x + 32, y + 32, x + 33, y + 33);

	for (i = 0; i < 32; i++){
		setPixel(data, data, imageWidth, x + 1 + i, y + 1,     x + 1 + i, y);
		setPixel(data, data, imageWidth, x + 1,     y + 1 + i, x,         y + 1 + i);
		setPixel(data, data, imageWidth, x + 1 + i, y + 32,    x + 1 + i, y + 33);
		setPixel(data, data, imageWidth, x + 32,    y + 1 + i, x + 33,    y + 1 + i);
	}
}

function copyMarks(targetData, marksData, targetWidth, marksWidth, marksHeight, MARK_TILE_ALPHA){
	for (var i = 0; i < marksWidth; i++){
		for (var j = 0; j < marksHeight; j++){
			setPixel2(marksData, targetData, targetWidth, i, j, i, j + 714, MARK_TILE_ALPHA);
		}
	}
}

function setPixel(sourceImageData, targetImageData, imageWidth, sourceX, sourceY, targetX, targetY){
	if (sourceX < 0 || sourceY < 0 || targetX < 0 || targetY < 0){
		return;
	}

	var sourceIdx = (imageWidth * sourceY + sourceX) << 2;
	var targetIdx = (imageWidth * targetY + targetX) << 2;

	targetImageData[targetIdx] = sourceImageData[sourceIdx];
	targetImageData[targetIdx + 1] = sourceImageData[sourceIdx + 1];
	targetImageData[targetIdx + 2] = sourceImageData[sourceIdx + 2];
	targetImageData[targetIdx + 3] = sourceImageData[sourceIdx + 3];
}

function setPixel2(sourceImageData, targetImageData, imageWidth, sourceX, sourceY, targetX, targetY, alpha){
	if (sourceX < 0 || sourceY < 0 || targetX < 0 || targetY < 0){
		return;
	}

	var sourceIdx = (imageWidth * sourceY + sourceX) << 2;
	var targetIdx = (imageWidth * targetY + targetX) << 2;

	if (sourceImageData[sourceIdx + 3] == 0){
		targetImageData[targetIdx + 3] = 0;
	} else {
		targetImageData[targetIdx + 3] = alpha;
	}
	targetImageData[targetIdx + 0] = sourceImageData[sourceIdx + 0];
	targetImageData[targetIdx + 1] = sourceImageData[sourceIdx + 1];
	targetImageData[targetIdx + 2] = sourceImageData[sourceIdx + 2];
}