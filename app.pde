
// Setting the height and width of the canvas element
var stageWidth = 800;
var stageHeight = 600;
var playerX = stageWidth/2 - 25;
var playerY = stageHeight/2 - 25;
var lastKeyPressed = "UP";
// The Setup loop prepares the stage for action!
void setup() {
	size(stageWidth,stageHeight);
	background(0,0,0);
}
var zombies = [];
var shurikens = [];

// This is what makes the game work. The draw loop constantly refreshes the canvas
void draw() {
	background(0,0,0);
	fill(255,255,255);
	DrawPlayer();
	UpdatePlayer();
	UpdateBullets();
}

var DrawPlayer = function() {
	fill(255,255,255);
	rect(playerX, playerY, 50, 50);
	println(playerY);
};

var UpdatePlayer = function() {
	if(keyPressed) {
		if(key == CODED) {
			switch (keyCode) {
				case UP:
					playerY--;
					break;
				case DOWN:
					playerY++;
					break;
				case LEFT:
					playerX--;
					break;
				case RIGHT:
					playerX++;
					break;
				default:
					// Do nothing
					break;
			}
		}
	}
	CheckPlayerBounds();
};

var CheckPlayerBounds = function() {
	if(playerX <= 0) {
		playerX = 0;
	} else if(playerX >= stageWidth - 50) {
		playerX = stageWidth - 50;
	} 

	if(playerY <= 0) {
		playerY = 0;
	} else if(playerY >= stageHeight - 50) {
		playerY = stageHeight - 50;
	}
};

var Shuriken = function(direction) {
	this.xPos = playerX;
	this.yPos = playerY;
	this.width = 10;
	this.height = 10;
	this.direction = direction;
}

var DrawBullets = function() {
	var shuriken = new Shuriken(lastKeyPressed);
	//ellipse(shuriken.xPos, shuriken.yPos, shuriken.width, shuriken.height);
	shurikens.push(shuriken);
};

var UpdateBullets = function() {
	for(var i = 0; i < shurikens.length; i++) {
		var shuriken = shurikens[i];
		ellipse(shuriken.xPos, shuriken.yPos, shuriken.width, shuriken.height);

	}
};
