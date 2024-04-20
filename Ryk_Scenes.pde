//Title
//Options
//Help
//Game
//End

class Title {
  float exitX, exitY, exitW, exitH;
  float gameX, gameY, gameW, gameH;
  float optionsX, optionsY, optionsW, optionsH;
  float helpX, helpY, helpW, helpH;
  float sharedW, sharedH;

  AABB play, help, options, exit;
  boolean overExit, overPlay, overHelp, overOptions;

  float randX;
  float byteRand;
  float descendY = 0;

  float[] binary = new float[100];

  Title() {
    sharedW = 200;
    sharedH = 100;

    exitX = 25;
    exitY = 25;
    exitW = 50;
    exitH = 50;

    gameX = width/2;
    gameY = height/4;
    gameW = sharedW;
    gameH = sharedH;

    optionsX = width/2;
    optionsY = height/2;
    optionsW = sharedW;
    optionsH = sharedH;

    helpX = width/2;
    helpY = height*3/4;
    helpW = sharedW;
    helpH = sharedH;

    prevMouse = false;
  }

  void update() {
    buttonPressed();
  }

  void draw() {
    background(128);
    backDrop();
    buttons();
  }

  void buttons() {

    textSize(40);
    fill(0);
    text("Title of Game Here", width/2, 75);

    rectMode(CORNER);
    exitButton();
    rectMode(CENTER);
    gameButton();
    helpButton();
    optionsButton();
  }

  void exitButton() {
    exit = new AABB(exitX, exitY, exitW, exitH, 0, 0);
    overExit = mouseOverButton(exit);

    if (overExit) {
      fill(255, 200, 0);
    } else {
      fill(255);
    }
    rect(exitX, exitY, exitW, exitH, 10);

    stroke(0);
    line(exitX + 5, exitY + 5, exitX + exitW - 5, exitY + exitH - 5);
    line(exitX + 5, exitY + exitH - 5, exitX + exitW - 5, exitY + 5);
    noStroke();
  }

  void gameButton() {
    play = new AABB(gameX - gameW/2, gameY - gameH/2, gameW, gameH, 0, 0);
    overPlay = mouseOverButton(play);

    if (overPlay) {
      fill(255, 200, 0);
    } else {
      fill(255);
    }
    rect(gameX, gameY, gameW, gameH);

    textAlign(CENTER);
    textSize(25);
    fill(0);
    text("Play", gameX, gameY+5);
  }

  void helpButton() {
    help = new AABB(helpX - helpW/2, helpY - helpH/2, helpW, helpH, 0, 0);
    overHelp = mouseOverButton(help);

    if (overHelp) {
      fill(255, 200, 0);
    } else {
      fill(255);
    }
    rect(helpX, helpY, helpW, helpH);

    textAlign(CENTER);
    textSize(25);
    fill(0);
    text("How To", helpX, helpY+5);
  }

  void optionsButton() {
    options = new AABB(optionsX - optionsW/2, optionsY - optionsH/2, optionsW, optionsH, 0, 0);
    overOptions = mouseOverButton(options);

    if (overOptions) {
      fill(255, 200, 0);
    } else {
      fill(255);
    }
    rect(optionsX, optionsY, optionsW, optionsH);

    textAlign(CENTER);
    textSize(25);
    fill(0);
    text("Options", optionsX, optionsY+5);
  }

  void backDrop() {
    fillArray();
    /*randX = random(width+1);
     
     byteRand = random((int) 2);
     */

    fill(0, 255, 0);
    text((int) byteRand, randX, descendY);
    noFill();
    descendY++;
  }

  void fillArray() {
    for (int i = 0; i < binary.length - 1; i++) {
      randX = random(width+1);
      byteRand = random((int) 2);
    }
  }

  boolean mouseOverButton(AABB other) {
    return mouseX > other.x &&
      mouseX < other.x+other.w &&
      mouseY > other.y &&
      mouseY < other.y+other.h;
  }

  void buttonPressed() {
    if (!prevMouse && mousePressed) {
      prevMouse = true;
      if (overExit) {
        closeApp();
      } else if (overPlay) {
        switchToGame();
      } else if (overHelp) {
        switchToHelp();
      } else if (overOptions) {
        switchToOptions();
      }
    } else if (!mousePressed) {
      prevMouse = false;
    }
  }
}


//OPTIONS CLASS---------------------------------------------------------



class Options {
  float backX, backY, backW, backH;
  float soundX, soundY, soundW, soundH;
  float musicX, musicY, musicW, musicH;
  float sharedW, sharedH;

  boolean overBack, overSound, overMusic;
  int adjY = 0;

  AABB back, sound, music;

  Options() {
    sharedW = 150;
    sharedH = 75;

    backX = 25;
    backY = 25;
    backW = 50;
    backH = 50;

    soundX = width/3;
    soundY = height/2;
    soundW = sharedW;
    soundH = sharedH;

    musicX = width*2/3;
    musicY = height/2;
    musicW = sharedW;
    musicH = sharedH;

    adjY = 0;

    prevMouse = false;
  }

  void update() {
    buttonPressed();
  }

  void draw() {
    background(128);
    fill(0);
    textSize(40);
    text("Options", width/2, 75);

    rectMode(CORNER);
    buttons();
    rectMode(CENTER);
    soundLever();
    musicLever();
  }

  void buttons() {
    backButton();
  }

  void backButton() {
    float triX1, triX2, triX3;
    float triY1, triY2, triY3;

    triX1 = backX + backW/4;
    triX2 = backX + backW/2;
    triX3 = triX2;

    triY1 = backY + backH/2;
    triY2 = backY + backH/4;
    triY3 = backY + backH*3/4;

    back = new AABB(backX, backY, backW, backH, 0, 0);
    overBack = mouseOverButton(back);

    if (overBack) {
      fill(255, 200, 0);
    } else {
      fill(255);
    }
    rect(backX, backY, backW, backH, 10);

    fill(0);
    triangle(triX1, triY1, triX2, triY2, triX3, triY3);
    rect(triX2, (triY1+triY2)/2, backW/3, backH/4);
  }

  void soundLever() {
    stroke(5);
    line(soundX, soundY-200, soundX, soundY+200);
    noStroke();

    sound = new AABB(soundX - soundW/2, soundY - soundH/2, soundW, soundH, 0, 0);
    overSound = mouseOverButton(sound);

    if (overSound) {
      fill(255, 200, 0);
    } else {
      fill(255);
    }
    rect(soundX, soundY, soundW, soundH);

    fill(0);
    text("Sound", soundX, soundY-250);
  }

  void musicLever() {


    stroke(5);
    line(musicX, musicY-200, musicX, musicY+200);
    noStroke();

    music = new AABB(musicX - musicW/2, (musicY - musicH/2) + adjY, musicW, musicH, 0, 0);
    overMusic = mouseOverButton(music);

    if (overMusic) {
      fill (255, 200, 0);
    } else {
      fill(255);
    }
    if (overMusic) {
      adjY += (sliderFunc(int (musicY)))-400;
      println(adjY);
    }
    rect(musicX, musicY+adjY, musicW, musicH);

    fill(0);
    text("Music", musicX, musicY-250);
  }

  int sliderFunc(int y) {
    if (mousePressed && y < height/2+200 && y > height/2-200) {
      y = mouseY;
    }
    return y;
  }

  boolean mouseOverButton(AABB other) {
    return mouseX > other.x &&
      mouseX < other.x+other.w &&
      mouseY > other.y &&
      mouseY < other.y+other.h;
  }

  void buttonPressed() {
    if (!prevMouse && mousePressed) {
      prevMouse = true;
      if (overBack) {
        switchToTitle();
      }
    } else if (!mousePressed) {
      prevMouse = false;
    }
  }
}



//HELP CLASS---------------------------------------------------------




class Help {
  float forwardX, forwardY, forwardW, forwardH;
  float backX, backY, backW, backH;
  float mainX, mainY, mainW, mainH;
  float triangleForwardX1, triangleForwardX2, triangleForwardX3, triangleForwardY1, triangleForwardY2, triangleForwardY3;
  float triangleBackX1, triangleBackX2, triangleBackX3, triangleBackY1, triangleBackY2, triangleBackY3;

  float sharedW, sharedH;
  boolean pageForward, pageBack;

  boolean overMain, overBack, overForward;

  AABB forward, back, main;

  int[] helpPages = new int[3];
  int i;

  Help() {
    sharedW = 75;
    sharedH = 75;

    mainX = 25;
    mainY = 25;
    mainW = 50;
    mainH = 50;

    forwardX = width*5/6;
    forwardY = height*6/7;
    forwardW = sharedW;
    forwardH = sharedH;

    backX = width/6;
    backY = height*6/7;
    backW = sharedW;
    backH = sharedH;

    forward = new AABB(forwardX - forwardW/2, forwardY - forwardH/2, forwardW, forwardH, 0, 0);
    back = new AABB(backX - backW/2, backY - backH/2, backW, backH, 0, 0);

    i = 0;

    helpPages[0] = 1;
    helpPages[1] = 2;
    helpPages[2] = 3;
  }

  void update() {
    buttonPressed();
  }

  void draw() {
    backGround();
    buttons();
    pages();

    fill(0);
    textSize(40);
    text("How to play", width/2, 75);
    i += pageNumber(i);
    text(helpPages[i], (width/5 + width*3/5 + width/20) + 15, mainY + 35);
    text(helpPages.length, (width/5 + width*3/5 + width/20) + 60, mainY + 65);

    stroke(3);
    line(width/5 + width*3/5 + width/20, mainY + sharedH, (width/5 + width*3/5 + width/20) + 75, mainY);
    noStroke();
  }

  void backGround() {
    float text1X, text1Y, text1W, text1H;
    float text2X, text2Y, text2W, text2H;
    float text3X, text3Y, text3W, text3H;

    rectMode(CORNER);
    text1X = width/5;
    text1Y = mainY;
    text1W = width*3/5;
    text1H = sharedH;

    text2X = text1X + text1W + width/20;
    text2Y = text1Y;
    text2W = 75;
    text2H = sharedH;

    text3X = mainX;
    text3Y = mainY + mainH + height/18;
    text3W = (text2X + text2W) - mainX;
    text3H = height*3/5;

    background(128);
    fill(255, 176, 102);
    rect(text1X, text1Y, text1W, text1H);
    rect(text2X, text2Y, text2W, text2H);
    rect(text3X, text3Y, text3W, text3H);
  }

  void buttons() {
    rectMode(CORNER);
    mainButton();
    rectMode(CENTER);
    forwardButton();
    backButton();
  }

  void mainButton() {
    float triX1, triX2, triX3;
    float triY1, triY2, triY3;

    triX1 = mainX + mainW/4;
    triX2 = mainX + mainW/2;
    triX3 = triX2;

    triY1 = mainY + mainH/2;
    triY2 = mainY + mainH/4;
    triY3 = mainY + mainH*3/4;

    main = new AABB(mainX, mainY, mainW, mainH, 0, 0);
    overMain = mouseOverButton(main);

    if (overMain) {
      fill(255, 200, 0);
    } else {
      fill(255);
    }
    rect(mainX, mainY, mainW, mainH, 10);

    fill(0);
    triangle(triX1, triY1, triX2, triY2, triX3, triY3);
    rect(triX2, (triY1+triY2)/2, mainW/3, mainH/4);
  }

  void forwardButton() {
    triangleForwardX1 = (forwardX + forwardW - 15) - (forwardW/2);
    triangleForwardX2 = (forwardX + 15) - (forwardW/2);
    triangleForwardX3 = triangleForwardX2;
    triangleForwardY1 = (forwardY + (forwardH/2)) - (forwardH/2);
    triangleForwardY2 = (forwardY + (forwardH/4)) - (forwardH/2);
    triangleForwardY3 = (forwardY + (forwardH*3/4)) - (forwardH/2);

    overForward = mouseOverButton(forward);

    if (overForward) {
      fill(255, 200, 0);
    } else {
      fill(255);
    }
    rect(forwardX, forwardY, forwardW, forwardH);

    fill(0);
    triangle(triangleForwardX1, triangleForwardY1, triangleForwardX2, triangleForwardY2, triangleForwardX3, triangleForwardY3);
  }

  void backButton() {
    triangleBackX1 = (backX + 15) - (backW/2);
    triangleBackX2 = (backX + backW - 15) - (backW/2);
    triangleBackX3 = triangleBackX2;
    triangleBackY1 = triangleForwardY1;
    triangleBackY2 = triangleForwardY2;
    triangleBackY3 = triangleForwardY3;

    overBack = mouseOverButton(back);

    if (overBack) {
      fill(255, 200, 0);
    } else {
      fill(255);
    }
    rect(backX, backY, backW, backH);

    fill(0);
    triangle(triangleBackX1, triangleBackY1, triangleBackX2, triangleBackY2, triangleBackX3, triangleBackY3);
  }

  void pages() {
    if (i == 0) {
      textSize(40);
      fill(0);
      text("This is page one", width/2, height/2);
    } else if (i == 1) {
      textSize(40);
      fill(0);
      text("This is page two", width/2, height/2);
    } else if (i == 2) {
      textSize(40);
      fill(0);
      text("This is page three", width/2, height/2);
    }
    noStroke();
  }

  int pageNumber(int i) {
    if (pageForward && i < helpPages.length-1) {
      pageForward = false;
      return 1;
    } else if (pageBack && i > 0) {
      pageBack = false;
      return -1;
    } else {
      return 0;
    }
  }

  boolean mouseOverButton(AABB other) {
    return mouseX > other.x &&
      mouseX < other.x+other.w &&
      mouseY > other.y &&
      mouseY < other.y+other.h;
  }

  void buttonPressed() {
    if (!prevMouse && mousePressed) {
      prevMouse = true;
      if (overMain) {
        switchToTitle();
      } else if (overForward) {
        pageForward = true;
      } else if (overBack) {
        pageBack = true;
      }
    } else if (!mousePressed) {
      prevMouse = false;
    }
  }
}

//GAME CLASS---------------------------------------------------------
class Game {

  Level level;

  Pathfinder pathfinder;
  float ram = 20;
  float ramMax = 20;
  float energy = 15;
  float energyChargeTimer =2;
  boolean isHeld;



  Game() {
    pathfinder = new Pathfinder();
    level = new Level();
  }

  void update() {
  }

  void draw() {
    background(128);

    level.draw();
    for (Tower tower : towers) {
      tower.draw();
      if (tower.towerType ==4 && energyChargeTimer <=0) {
        energy +=1;
        energyChargeTimer =2;
      }
      else energyChargeTimer -=1*DeltaTime;
      println(energyChargeTimer);
    }
    for(int i =0;i<towers.size()-1;i++){
     if(towers.get(i).isDead) towers.remove(i);
    }



    //Shop
    shop();
    button(825, 100, 75, 75, "BASIC");
    button(975, 100, 75, 75, "SUPPORT");
    button(825, 200, 75, 75, "ELECTRIC");
    button(975, 200, 75, 75, "POWER");
    //UI
    UI();
  }

  void button(float x, float y, float w, float h, String type) {
    boolean isHovered = false;
    boolean wasHeld =false;
    //UPDATE
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      isHovered = true;
    } else {
      isHovered = false;
    }
    if (isHovered || isHeld) {
      if (leftMouseClick) {
        isHeld = true;
      }
    }
    if (leftMouseRelease && isHeld == true) {
      isHeld = false;
      if (type == "BASIC") {
        if (energy >= 10) {
          Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
          Tile tile = level.getTile(g);
          if (tile.TERRAIN ==70) {
            energy -=10;
            towers.add(new Tower (mouseX-16, mouseY-16, 4));
            tile.TERRAIN = 71;
          }
        }
      } else if (type == "SUPPORT") {
        if (energy >= 10) {
          Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
          Tile tile = level.getTile(g);
          if (tile.TERRAIN ==70) {
            energy -=10;
            towers.add(new Tower (mouseX-16, mouseY-16, 1));
            tile.TERRAIN = 72;
          }
        }
      } else if (type == "ELECTRIC") {
        if (energy >= 10) {
          Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
          Tile tile = level.getTile(g);
          if (tile.TERRAIN ==70) {
            energy -=1;
            towers.add(new Tower (tile.X-16, tile.Y-16, 2));
            tile.TERRAIN = 73;
          }
        }
      } else if (type == "POWER") {
        if (energy >= 10) {
          Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
          Tile tile = level.getTile(g);
          if (tile.TERRAIN ==70) {
            energy -=10;
            towers.add(new Tower (mouseX-16, mouseY-16, 4));
            tile.TERRAIN = 74;
          }
        }
      }
    }
    //DRAW
    if (!isHovered) fill(0);
    else fill(50);
    stroke(0);
    strokeWeight(3);
    rectMode(CORNER);
    rect(x, y, w, h, 3);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(15);
    text(type, x + (w/2), y + (h/2));
    if (isHeld) {
      rectMode(CENTER);
      strokeWeight(3);
      stroke(0);
      rect(mouseX, mouseY, 29, 29, 3);
      wasHeld =true;
    }
  }

  void shop() {
    fill(80);
    rectMode(CORNER);
    rect(800, 0, 280, 1080);
    fill(0);
    textAlign(CENTER, CENTER);
    text("TOWERS", 940, 50);
    text("UPGRADES", 940, 500);
  }

  void UI() {
    float barPercent = (ram/ramMax) * 150;
    fill(80);
    rectMode(CORNER);
    rect(0, 0, 200, 100);
    fill(255, 255, 0);
    textSize(20);
    textAlign(LEFT, CENTER);
    text("ENERGY: " + round(energy), 25, 25);
    rectMode(CORNER);
    strokeWeight(3);
    stroke(0);
    fill(0, 0, 0, 0);
    rect(25, 50, 150, 20);
    fill(5, 217, 255);
    rect(25, 50, barPercent, 20);
  }
}

//END CLASS---------------------------------------------------------
class End {

  void update() {
  }

  void draw() {
  }

  void buttons() {
  }
}
