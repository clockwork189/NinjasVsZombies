
// Setting the height and width of the canvas element
var stageWidth = 800;
var stageHeight = 600;

var NUM_LIVES = 3;

var player = {
	lives: NUM_LIVES,
	xPos: stageWidth/2 - 25,
	yPos: stageHeight/2 - 25,
	lastFired: -Infinity
};

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
	DrawShurikens();
	UpdateShurikens();
}

var DrawPlayer = function() {
	fill(255,255,255);
	rect(player.xPos, player.yPos, 50, 50);
};

var UpdatePlayer = function() {
	if(keyPressed) {
		if(key == CODED) {
			/*
				if(keyCode == UP) {
					player.yPos--;
				}

				if(keyCode == DOWN) {
					player.yPos++;
				}

				if(keyCode == LEFT) {
					player.xPos--;	
				}

				if(keyCode == RIGHT) {
					player.xPos++;
				}
			*/

			switch (keyCode) {
				case UP:
					player.yPos--;
					break;
				case DOWN:
					player.yPos++;
					break;
				case LEFT:
					player.xPos--;
					break;
				case RIGHT:
					player.xPos++;
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
	if(player.xPos <= 0) {
		player.xPos = 0;
	} else if(player.xPos >= stageWidth - 50) {
		player.xPos = stageWidth - 50;
	} 

	if(player.yPos <= 0) {
		player.yPos = 0;
	} else if(player.yPos >= stageHeight - 50) {
		player.yPos = stageHeight - 50;
	}
};

var Shuriken = function() {
	this.xPos = player.xPos + 25;
	this.yPos = player.yPos + 25;
	this.OrigXPos = player.xPos + 25;
	this.OrigYPos = player.yPos + 25;
	this.width = 10;
	this.height = 10;
	this.targetX = mouseX;
	this.targetY = mouseY;
	this.slope = (this.OrigYPos - this.targetY)/(this.OrigXPos - this.targetX);
	this.angle = atan((this.OrigYPos - this.targetY)/(this.OrigXPos - this.targetX));
}

var DrawShurikens = function() {
	if(!mousePressed) {
		return;
	}

	if(frameCount - player.lastFired < 30) {
		return;
	}

	var shuriken = new Shuriken();
	shurikens.push(shuriken);

	player.lastFired = frameCount;
};

var UpdateShurikens = function() {
	for(var i = 0; i < shurikens.length; i++) {
		var shuriken = shurikens[i];
		
		ellipse(shuriken.xPos, shuriken.yPos, shuriken.width, shuriken.height);

		if(shuriken.targetX < shuriken.OrigXPos) {
			shuriken.xPos -= 5;
		} else {
			shuriken.xPos += 5;
		}
		var intercept = shuriken.OrigYPos - shuriken.slope * shuriken.OrigXPos;
		if(shuriken.targetY < shuriken.OrigYPos) {
			shuriken.yPos = shuriken.slope * shuriken.xPos + intercept;
		} else {
			shuriken.yPos = shuriken.slope * shuriken.xPos + intercept;
		}

		if(shuriken.xPos <= 0 || shuriken.xPos >= stageWidth || shuriken.yPos <= 0 || shuriken.yPos >= stageHeight) {
			shurikens.splice(i, 1);
		}
	}
};

