class Robot extends Enemy {
	// Requirement #5: Complete Dinosaur Class

	final int PLAYER_DETECT_RANGE_ROW = 2;
	final int LASER_COOLDOWN = 180;
	final int HAND_OFFSET_Y = 37;
	final int HAND_OFFSET_X_FORWARD = 64;
	final int HAND_OFFSET_X_BACKWARD = 16;
  float currentSpeed = 2f;
  int timer = LASER_COOLDOWN ;
  Laser laser;

  Robot(float x, float y){
    super(x,y);
    laser = new Laser();
  }
  
  void update () {
    
    boolean checkX = ( currentSpeed > 0 && player.x + w/2 > x+HAND_OFFSET_X_FORWARD )
            || ( currentSpeed < 0 && player.x + w/2 < x+HAND_OFFSET_X_BACKWARD );
  
    boolean checkY = player.y >= y-(2*SOIL_SIZE) && player.y <= y+(2*SOIL_SIZE); 
  
    if(checkX && checkY){
      if(timer < LASER_COOLDOWN){
        timer++;
      }
      if(timer == LASER_COOLDOWN){
        laser.fire((currentSpeed > 0) ? x+HAND_OFFSET_X_FORWARD : x+HAND_OFFSET_X_BACKWARD ,y+HAND_OFFSET_Y,player.x + w/2,player.y + h/2);
        timer = 0;
      }
    }else{
      x += currentSpeed ;
      if (x < 0 || x > width - w) { 
        currentSpeed *= -1 ;
      }
      timer = LASER_COOLDOWN;
    }
    laser.update();
  
  }
  
  void display(){
    int direction = (currentSpeed > 0) ? RIGHT : LEFT;
    
    pushMatrix();
    translate(x, y);
    if (direction == RIGHT) {
      scale(1, 1);
      image(robot, 0, 0, w, h);
    } else {
      scale(-1, 1);
      image(robot, -w, 0, w, h);
    }
    popMatrix();
    laser.display();
  }
  
    void checkCollision(Player player){

    if(isHit(x, y, w, h, player.x, player.y, player.w, player.h)){
      player.hurt();
    }
    laser.checkCollision(player);
  }

	// HINT: Player Detection in update()
	/*

	boolean checkX = ( Is facing forward AND player's center point is in front of my hand point )
					OR ( Is facing backward AND player's center point (x + w/2) is in front of my hand point )

	boolean checkY = player is less than (or equal to) 2 rows higher or lower than me

	if(checkX AND checkY){
		Is laser's cooldown ready?
			True  > Fire laser from my hand!
			False > Don't do anything
	}else{
		Keep moving!
	}

	*/
}
