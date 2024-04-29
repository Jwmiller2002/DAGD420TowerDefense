import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Title title;
Options options;
Help help;
Game game;
End end; //Game Over
Credits credits;

Minim minim;
AudioPlayer bgm;
FFT bgmFFT;
AudioPlayer sfx1; //Menubutton click
FFT fxFFT;
AudioPlayer menu;
FFT menuFFT;

boolean prevMouse;
float timeLasted =0;
boolean gameOver;

ArrayList<Tower> towers;
float prevMillis;
float DeltaTime;

//Inputs
boolean leftMouseHeld = false;
boolean leftMouseClick = false;
boolean leftMouseRelease = false;
boolean prevLeftMouseClick = false;
 

void setup() {
  //fullScreen();
  init();
  size(1080, 1080);
  TileHelper.app = this;
  towers = new ArrayList<Tower>();

  prevMillis=0;
  DeltaTime=0;
  
  minim = new Minim(this);
  bgm = minim.loadFile("DigitalBackground.mp3", 1024);
  bgmFFT = new FFT(bgm.bufferSize(), bgm.sampleRate());
  
  sfx1 = minim.loadFile("MenuSFX.mp3", 1024);
  fxFFT = new FFT(sfx1.bufferSize(), sfx1.sampleRate());
  
  menu = minim.loadFile("MenuMusic.mp3", 1024);
  menuFFT = new FFT(menu.bufferSize(), menu.sampleRate());
  
  menu.setGain(-17.5);
}

void init() {
  //Switch this code to choose the scene that first appears when booting the program up
  switchToTitle();
}

void draw() {

  /* This is the Scene manager code.
   * It checks the update to see if any scenes switching should happen.
   * Then it draws the scene
   */
  CalcDeltaTime();

  if (title != null) {
    title.update();
    menu.play();
    if (title != null) {
      title.draw();
    }
  } else if (options != null) {
    options.update();
    if (options != null) {
      options.draw();
    }
  } else if (help != null) {
    help.update();
    if (help != null) {
      help.draw();
    }
  } else if (game != null) {
    game.update();
    bgm.play();
    if (game != null) {
      game.draw();
    }
  } else if (end != null) {
    end.update();
    if (end != null) {
      end.draw();
    }
  } else if (credits != null) {
    credits.update();
    if (credits != null) {
      credits.draw();
    }
  }
  prevLeftMouseClick = leftMouseClick;
  leftMouseRelease = false;
}
//INPUTS
void mousePressed() {
  leftMouseClick = true;
}
void mouseReleased() {
  leftMouseClick = false;
  leftMouseRelease = true;
}

//SCENES
void switchToTitle() {
  title = new Title();
  options = null;
  help = null;
  game = null;
  end = null;
  credits = null;
}

void switchToOptions() {
  title = null;
  options = new Options();
  help = null;
  game = null;
  end = null;
  credits = null;
}

void switchToHelp() {
  title = null;
  options = null;
  help = new Help();
  game = null;
  end = null;
  credits = null;
}

void closeApp() {
  exit();
}

void switchToGame() {
  title = null;
  options = null;
  help = null;
  game = new Game();
  end = null;
  credits = null;
}

void switchToEnd() {
  title = null;
  options = null;
  help = null;
  game = null;
  end = new End();
  credits = null;
}

void switchToCredits() {
  title = null;
  options = null;
  help = null;
  game = null;
  end = null;
  credits = new Credits();
}

void CalcDeltaTime() {
  DeltaTime=(millis()-prevMillis)/1000f;
  prevMillis = millis();
}
