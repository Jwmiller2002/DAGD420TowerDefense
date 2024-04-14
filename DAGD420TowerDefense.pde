
Title title;
Options options;
Help help;
Game game;
End end; //Game Over 

boolean prevMouse;
ArrayList<Tower> towers;


void setup(){
  //fullScreen();
  init();
  size(1080, 1080);
  TileHelper.app = this;
  
  
}

void init(){
  //Switch this code to choose the scene that first appears when booting the program up
  switchToTitle();
}

void draw(){
  
  /* This is the Scene manager code. 
   * It checks the update to see if any scenes switching should happen.
   * Then it draws the scene
   */
  
  if(title != null){
    title.update();
    if(title != null){
      title.draw();
    }
  }
  else if(options != null){
    options.update();
    if(options != null){
      options.draw();
    }
  }
  else if(help != null){
    help.update();
    if(help != null){
      help.draw();
    }
  }
  else if(game != null){
    game.update();
    if(game != null){
      game.draw();
    }
  }
  else if(end != null){
    end.update();
    if(end != null){
      end.draw();
    }
  }
  
}

void switchToTitle(){
  title = new Title();
  options = null;
  help = null;
  game = null;
  end = null;
}

void switchToOptions(){
  title = null;
  options = new Options();
  help = null;
  game = null;
  end = null;
}

void switchToHelp(){
  title = null;
  options = null;
  help = new Help();
  game = null;
  end = null;
}

void closeApp(){
  exit();
}

void switchToGame(){
  title = null;
  options = null;
  help = null;
  game = new Game();
  end = null;
}

void switchToEnd(){
  title = null;
  options = null;
  help = null;
  game = null;
  end = new End();
}
