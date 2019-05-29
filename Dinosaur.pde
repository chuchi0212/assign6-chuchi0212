class Dinosaur extends Enemy {
	// Requirement #4: Complete Dinosaur Class

	final float TRIGGERED_SPEED_MULTIPLIER = 5;
  float currentSpeed = 2f/2;
  
  Dinosaur(float x, float y){
    super(x,y);
  }
  
  void update () {
    x += currentSpeed ;
    
    if (x < 0 || x > width - w) { 
      currentSpeed *= -1 ;
    } 
    if(player.y == y && player.x > x && currentSpeed == 2f/2 ){
      currentSpeed *= TRIGGERED_SPEED_MULTIPLIER;
    }
    if(player.y == y && player.x < x && currentSpeed == -(2f/2)){
      currentSpeed *= TRIGGERED_SPEED_MULTIPLIER;
    }
    if(player.y != y ){
      currentSpeed = (currentSpeed > 0) ?  2f/2 :  -(2f/2);
    }

  }
  
  void display(){
    int direction = (currentSpeed > 0) ? RIGHT : LEFT;
    
    pushMatrix();
    translate(x, y);
    if (direction == RIGHT) {
      scale(1, 1);
      image(dinosaur, 0, 0, w, h); 
    } else {
      scale(-1, 1);
      image(dinosaur, -w, 0, w, h); 
    }
    popMatrix();
  } 
  
    
  
	// HINT: Player Detection in update()
	/*
	float currentSpeed = speed
	If player is on the same row with me AND (it's on my right side when I'm going right OR on my left side when I'm going left){
		currentSpeed *= TRIGGERED_SPEED_MULTIPLIER
	}
	*/
}
