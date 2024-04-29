//Title 7-218
//Options 218-386
//Help 386-634
//Game 634-1135
//End 1135-11??
//Credits 1156-1200

class Title {
  float exitX, exitY, exitW, exitH;
  float gameX, gameY, gameW, gameH;
  float optionsX, optionsY, optionsW, optionsH;
  float helpX, helpY, helpW, helpH;
  float creditsX, creditsY, creditsW, creditsH;
  float sharedW, sharedH;

  AABB play, help, options, exit, credits;
  boolean overExit, overPlay, overHelp, overOptions, overCredits;

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
    gameY = height/5;
    gameW = sharedW;
    gameH = sharedH;

    optionsX = width/2;
    optionsY = height*2/5;
    optionsW = sharedW;
    optionsH = sharedH;

    helpX = width/2;
    helpY = height*3/5;
    helpW = sharedW;
    helpH = sharedH;
    
    creditsX = width/2;
    creditsY = height*4/5;
    creditsW = sharedW;
    creditsH = sharedH;
    
    prevMouse = false;
  }

  void update() {
    buttonPressed();
  }

  void draw() {
    background(0, 64, 0);
    backDrop();
    buttons();
  }

  void buttons() {

    textSize(40);
    fill(255);
    text("Yeet the Virus TD", width/2, 75);

    rectMode(CORNER);
    exitButton();
    rectMode(CENTER);
    gameButton();
    helpButton();
    optionsButton();
    creditsButton();
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
  
  void creditsButton(){
    credits = new AABB(creditsX - creditsW/2, creditsY - creditsH/2, creditsW, creditsH, 0, 0);
    overCredits = mouseOverButton(credits);
    
    if(overCredits){
      fill(255, 200, 0);
    } else {
      fill(255);
    }
    rect(creditsX, creditsY, creditsW, creditsH);
    
    textAlign(CENTER);
    textSize(25);
    fill(0);
    text("Credits", creditsX, creditsY);
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
    if (descendY > height) {
      descendY = 0;
    }
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
        sfx1.play();
        closeApp();
      } else if (overPlay) {
        sfx1.play();
        switchToGame();
      } else if (overHelp) {
        switchToHelp();
      } else if (overOptions) {
        switchToOptions();
      } else if (overCredits){
        switchToCredits();
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
    background(0, 64, 0);
    fill(255);
    textSize(40);
    text("Options", width/2, 75);
    
    backDrop();
    
    rectMode(CORNER);
    buttons();
    rectMode(CENTER);
    soundLever();
    musicLever();
  }
  
  void backDrop(){
    fill(78, 156, 0);
    rectMode(CORNER);
    rect(soundX-80, soundY-300, 160, 600);
    rect(musicX-80, musicY-300, 160, 600);
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
      ////////println(adjY);
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
    textAlign(CENTER);
    text("How to play", width/2, 75);
    i += pageNumber(i);
    textAlign(LEFT);
    text(helpPages[i], (width/5 + width*3/5 + width/12), mainY + 35);
    text(helpPages.length, (width/5 + width*3/5 + width/12) + 45, mainY + 65);

    stroke(3);
    line(width/5 + width*3/5 + width/12, mainY + sharedH, (width/5 + width*3/5 + width/12) + 75, mainY);
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

    text2X = text1X + text1W + width/12;
    text2Y = text1Y;
    text2W = 75;
    text2H = sharedH;

    text3X = mainX;
    text3Y = mainY + mainH + height/18;
    text3W = (text2X + text2W) - mainX;
    text3H = height*3/5;

    background(0, 64, 0);
    fill(78, 156, 0);
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
      textSize(32);
      fill(0);
      textAlign(LEFT);
      text("Built towers to protect the Computer from those nasty Viruses", mainX + width/100, (mainY + mainH + height/18) + height/30);
      text("Use Energy to build towers", mainX + width/100, (mainY + mainH + height/18) + height/30 + 40);
      text("Be careful, each tower uses a limied resource call RAM", mainX + width/100, (mainY + mainH + height/18) + height/30 + 80);
      text("Once you run out, no tower besides RAM can be built", mainX + width/100, (mainY + mainH + height/18) + height/30 + 120);
      text("On the top left of HUD is where your Energy and RAM", mainX + width/100, (mainY + mainH + height/18) + height/30 + 160);
      text("are displayed", mainX + width/100, (mainY + mainH + height/18) + height/30 + 200);
      text("The number shows your Energy for buying,", mainX + width/100, (mainY + mainH + height/18) + height/30 + 240);
      text("and the blue bars shows your capacity to build", mainX + width/100, (mainY + mainH + height/18) + height/30 + 280);
    } else if (i == 1) {
      textSize(32);
      fill(0);
      textAlign(LEFT);
      text("There are 5 towers,", mainX + width/100, (mainY + mainH + height/18) + height/30);
      text("A basic tower that shoots the enemies 'BASIC'", mainX + width/100, (mainY + mainH + height/18) + height/30 + 40);
      text("A tower that does a burst AoE around the tower 'AOE'", mainX + width/100, (mainY + mainH + height/18) + height/30 + 80);
      text("A tower that acts like a wall that blocks the enemies way 'WALL'", mainX + width/100, (mainY + mainH + height/18) + height/30 + 120);
      text("A tower that generates Energy 'POWER'", mainX + width/100, (mainY + mainH + height/18) + height/30 + 160);
      text("A tower that increases your RAM capacity 'RAM'", mainX + width/100, (mainY + mainH + height/18) + height/30 + 200);
      text("These towers can only be build on the light green squares", mainX + width/100, (mainY + mainH + height/18) + height/30 + 240);
      text("Wall towers can be built nearly any", mainX + width/100, (mainY + mainH + height/18) + height/30 + 280);
    } else if (i == 2) {
      textSize(35);
      fill(0);
      textAlign(LEFT);
      text("This is page three", mainX+width/100, height/2);
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
  float energy = 100;
  float energyChargeTimer =3;
  float lackEnergyTimer = 0;
  float lackRamTimer = 0;
  boolean isBasicHeld;
  boolean isSupportHeld;
  boolean isPowerHeld;
  boolean isAOEHeld;
  boolean isRAMHeld;
  EnemyManager enemyMan;
  int enemyCount;
  float enemyDensity;
  float waveTimer;
  int waveCount;



  Game() {
    pathfinder = new Pathfinder();
    level = new Level();
    enemyMan = new EnemyManager();
    waveTimer=5;
    enemyCount=3;
    enemyDensity=1;
    waveCount=1;
  }

  void update() {
    lackEnergyTimer -= DeltaTime;
    lackRamTimer -= DeltaTime;


    //enemyManager update and check for all dead
    enemyMan.update();

    if (enemyMan.enemies.size() <=0 && enemyMan.spawnLeft<=0) {
      waveTimer-=DeltaTime;
      if (waveTimer<=0) {
        enemyMan.spawnLeft = enemyCount;
        enemyCount+=2;
        enemyMan.MaxSpawnTimer = enemyDensity;
        if (waveCount<90) {
          enemyDensity = 1 - waveCount/100f;
        } else {
          enemyDensity=.1;
        }
        waveCount++;
        waveTimer = 5;
      }//end wave timer
    }//end if wave done
  }

  void draw() {
    background(128);
    ////////println(mouseX + " " + mouseY);

    level.draw();
    //enemy draw
    enemyMan.draw();
    //Shop
    shop();
    //UI
    UI();
    for (int i =0; i<towers.size(); i++) {
      Tower t = towers.get(i);
      t.draw();
      if (t.towerType ==4 && energyChargeTimer <=0) { //Energy Tower
        energy +=1;
        energyChargeTimer =3;
      } else {
        energyChargeTimer -= 1*DeltaTime;
      }
      if (leftMouseClick && !prevLeftMouseClick && mouseX<800) { //
        Point g = TileHelper.pixelToGrid(new PVector(t.x, t.y));
        Tile tile = level.getTile(g);
        if (tile.TERRAIN >=70 && tile.TERRAIN <=75) {  //UPGRADE TOWER
        }
      }

      if (t.towerType == 1) { //ram tower
        if (t.ramIncreased ==false) { //ram increase
          t.ramIncreased =true;
          ram += 10;
          ramMax += 10;
        }
        if (ram > ramMax) { //OVER MAXIMUM
        } else if (ram == ramMax) { //AT MAX
        } else { //BELOW MAX
        }
      }

      if (t.isDead) {                                          //DEATH
        Point g = TileHelper.pixelToGrid(new PVector(t.x, t.y));
        Tile tile = level.getTile(g);
        if (t.ramTower) ramMax--;
        tile.TERRAIN =70;
        towers.remove(i);
      }
    }

    if (lackEnergyTimer > 0) {
      fill(0);
      rectMode(CENTER);
      rect((width/2) - 130, 75, 400, 100, 3);
      textAlign(CENTER, CENTER);
      fill(255, 255, 0);
      textSize(30);
      text("NOT ENOUGH ENERGY", (width/2) - 130, 75);
      rectMode(CORNER);
    }
    if (lackRamTimer > 0) {
      fill(0);
      rectMode(CENTER);
      rect((width/2) - 130, 75, 400, 100, 3 );
      textAlign(CENTER, CENTER);
      fill(255, 255, 0);
      textSize(30);
      text("NOT ENOUGH RAM", (width/2) - 130, 75);
      rectMode(CORNER);
    }
  }

  void basicButton(float x, float y, float w, float h, String type) {
    boolean isHovered = false;
    boolean wasHeld =false;
    //UPDATE
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      isHovered = true;
      rectMode(CORNER);
      strokeWeight(3);
      stroke(0);
      fill(150);
      rect(820, 800, 240, 200);
      fill(0);
      textSize(25);
      textAlign(CENTER, CENTER);
      text("ANTI VIRUS", 940, 825);
      textSize(15);
      text("Attacks enemies from a distance", 940, 850);
      text("Energy Cost: 10", 940, 875);
      text("RAM Cost: 4", 940, 900);
    } else {
      isHovered = false;
    }
    if (isHovered || isBasicHeld) {
      if (!isSupportHeld && !isPowerHeld && !isAOEHeld && !isRAMHeld) {
        if (leftMouseClick) {
          isBasicHeld = true;
        }
      }
    }
    if (leftMouseRelease && isBasicHeld == true) {
      isBasicHeld = false;
      if (energy >= 10 && mouseX<800 && ram >=4) {
        Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
        Tile tile = level.getTile(g);
        if (tile.TERRAIN ==70) {
          energy -=10;
          ram -=4;
          tile.TERRAIN = 71;
          towers.add(new Tower (mouseX-16, mouseY-16, 0));
        }
      } else if (energy < 10) {
        lackEnergyTimer = .5;
      } else if (ram < 4) {
        lackRamTimer = .5;
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
    fill(255, 255, 0);
    text("10", x + 12, y +10);
    fill(5, 217, 255);
    text("4", x + (w-12), y +10);
    if (isBasicHeld) {
      rectMode(CENTER);
      strokeWeight(0);
      stroke(0);
      fill(0, 200, 255);
      rect(mouseX, mouseY, 29, 29);
      wasHeld =true;
    }
  }
  void supportButton(float x, float y, float w, float h, String type) {
    boolean isHovered = false;
    boolean wasHeld =false;
    //UPDATE
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      isHovered = true;
      rectMode(CORNER);
      strokeWeight(3);
      stroke(0);
      fill(150);
      rect(820, 800, 240, 200);
      fill(0);
      textSize(25);
      textAlign(CENTER, CENTER);
      text("FIREWALL", 940, 825);
      textSize(15);
      text("Blocks enemies", 940, 850);
      text("Energy Cost: 5", 940, 875);
      text("RAM Cost: 1", 940, 900);
    } else {
      isHovered = false;
    }
    if (isHovered || isSupportHeld) {
      if (!isBasicHeld && !isPowerHeld && !isAOEHeld && !isRAMHeld) {
        if (leftMouseClick) {
          isSupportHeld = true;
        }
      }
    }
    if (leftMouseRelease && isSupportHeld == true) {
      isSupportHeld = false;
      if (energy >= 5 && mouseX<800 && ram >= 1) {
        Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
        Tile tile = level.getTile(g);
        if (tile.TERRAIN ==70 || tile.TERRAIN == 1 || tile.TERRAIN == 0) {
          energy -=5;
          ram -=1;
          tile.TERRAIN = 73;
          towers.add(new Tower (mouseX-16, mouseY-16, 2));
        }
      } else if (energy < 5) {
        lackEnergyTimer = .5;
      } else if (ram < 1) {
        lackRamTimer = .5;
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
    fill(255, 255, 0);
    text("5", x + 12, y +10);
    fill(5, 217, 255);
    text("1", x + (w-12), y +10);
    if (isSupportHeld) {
      rectMode(CENTER);
      strokeWeight(0);
      stroke(0);
      fill(0, 0, 139);
      rect(mouseX, mouseY, 29, 29);
      wasHeld =true;
    }
  }
  void powerButton(float x, float y, float w, float h, String type) {
    boolean isHovered = false;
    boolean wasHeld =false;
    //UPDATE
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      isHovered = true;
      rectMode(CORNER);
      strokeWeight(3);
      stroke(0);
      fill(150);
      rect(820, 800, 240, 200);
      fill(0);
      textSize(25);
      textAlign(CENTER, CENTER);
      text("POWER SOURCE", 940, 825);
      textSize(15);
      text("Slowly generates energy", 940, 850);
      text("Energy Cost: 15", 940, 875);
      text("RAM Cost: 10", 940, 900);
    } else {
      isHovered = false;
    }
    if (isHovered || isPowerHeld) {
      if (!isSupportHeld && !isBasicHeld && !isAOEHeld && !isRAMHeld) {
        if (leftMouseClick) {
          isPowerHeld = true;
          ////////println("PowerCLICK");
        }
      }
    }
    if (leftMouseRelease && isPowerHeld == true) { 
      isPowerHeld = false;
      if (energy >= 15 && mouseX<800 && ram >= 10) {
        Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
        Tile tile = level.getTile(g);
        if (tile.TERRAIN ==70) {
          energy -=15;
          ram -=10;
          towers.add(new Tower (mouseX-16, mouseY-16, 4));
          tile.TERRAIN = 74;
        }
      } else if (energy < 15) {
        lackEnergyTimer = .5;
      } else if (ram < 10) {
        lackRamTimer = .5;
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
    fill(255, 255, 0);
    text("15", x + 12, y +10);
    fill(5, 217, 255);
    text("10", x + (w-12), y +10);
    if (isPowerHeld) {
      rectMode(CENTER);
      strokeWeight(0);
      stroke(0);
      fill(255, 255, 10);
      rect(mouseX, mouseY, 29, 29);
      wasHeld =true;
    }
  }
  void aoeButton(float x, float y, float w, float h, String type) {
    boolean isHovered = false;
    boolean wasHeld =false;
    //UPDATE
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      isHovered = true;
      rectMode(CORNER);
      strokeWeight(3);
      stroke(0);
      fill(150);
      rect(820, 800, 240, 200);
      fill(0);
      textSize(25);
      textAlign(CENTER, CENTER);
      text("ELECTRO VENT", 940, 825);
      textSize(15);
      text("Shocks all nearby enemies", 940, 850);
      text("Energy Cost: 12", 940, 875);
      text("RAM Cost: 3", 940, 900);
    } else {
      isHovered = false;
    }
    if (isHovered || isAOEHeld) {
      if (!isSupportHeld && !isPowerHeld && !isBasicHeld && !isRAMHeld) {
        if (leftMouseClick) {
          isAOEHeld = true;
          ////////println("PowerCLICK");
        }
      }
    }
    if (leftMouseRelease && isAOEHeld == true) { 
      isAOEHeld = false;
      if (energy >= 12 && mouseX<800 && ram >= 3) {
        Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
        Tile tile = level.getTile(g);
        if (tile.TERRAIN ==70) {
          energy -=  12;
          ram -=3;
          towers.add(new Tower (mouseX-16, mouseY-16, 3));
          tile.TERRAIN = 75;
        }
      } else if (energy < 12) {
        lackEnergyTimer = .5;
      } else if (ram < 3) {
        lackRamTimer = .5;
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
    fill(255, 255, 0);
    text("12", x + 12, y +10);
    fill(5, 217, 255);
    text("3", x + (w-12), y +10);
    if (isAOEHeld) {
      rectMode(CENTER);
      strokeWeight(0);
      stroke(0);
      fill(255, 0, 255);
      rect(mouseX, mouseY, 29, 29);
      wasHeld =true;
    }
  }
  void ramButton(float x, float y, float w, float h, String type) {
    boolean isHovered = false;
    boolean wasHeld =false;
    //UPDATE
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      isHovered = true;
      rectMode(CORNER);
      strokeWeight(3);
      stroke(0);
      fill(150);
      rect(820, 800, 240, 200);
      fill(0);
      textSize(25);
      textAlign(CENTER, CENTER);
      text("RAM STICK", 940, 825);
      textSize(15);
      text("Increases RAM by 10", 940, 850);
      text("Energy Cost: 20", 940, 875);
    } else {
      isHovered = false;
    }
    if (isHovered || isRAMHeld) {
      if (!isSupportHeld && !isPowerHeld && !isAOEHeld && !isBasicHeld) {
        if (leftMouseClick) {
          isRAMHeld = true;
          ////////println("PowerCLICK");
        }
      }
    }
    if (leftMouseRelease && isRAMHeld == true) { 
      isRAMHeld = false;
      if (energy >= 20 && mouseX<800) {
        Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
        Tile tile = level.getTile(g);
        if (tile.TERRAIN ==70) {
          energy -=  20;
          towers.add(new Tower (mouseX-16, mouseY-16, 1));
          tile.TERRAIN = 72;
        }
      } else if (energy < 20) {
        lackEnergyTimer = .5;
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
    fill(255, 255, 0);
    text("20", x + 12, y +10);
    if (isRAMHeld) {
      rectMode(CENTER);
      strokeWeight(0);
      stroke(0);
      fill(255, 200, 0);
      rect(mouseX, mouseY, 29, 29);
      wasHeld =true;
    }
  }

  void shop() {
    fill(80);
    rectMode(CORNER);
    rect(800, 0, 280, 1080);
    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("TOWERS", 940, 50);
    //text("UPGRADES", 940, 500);
    basicButton(825, 100, 75, 75, "BASIC");
    supportButton(975, 100, 75, 75, "WALL");
    powerButton(975, 200, 75, 75, "POWER");
    aoeButton(825, 200, 75, 75, "AOE");
    ramButton(900, 300, 75, 75, "RAM");
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
    fill(0, 0, 139);
    textSize(15);
    textAlign(CENTER, CENTER);
    text(round(ram) + "/" + round(ramMax), 100, 57);
  }
}

//END CLASS---------------------------------------------------------
class End {
  
  float backX, backY, backW, backH;
  AABB back;
  boolean overBack;
  
  float restartX, restartY, restartW, restartH;
  AABB restart;
  boolean overRestart;
  
  End(){
    backX = width/20+10;
    backY = height/20+10;
    backW = 100;
    backH = 100;
    
    restartX = width*17/20-10;
    restartY = height/20+10;
    restartW = 100;
    restartH = 100;
    
  }
  
  void update() {
    buttonPressed();
  }

  void draw() {
    background(0, 64, 0);
    fill(78, 156, 0);
    rect(width/20, height/20, width*18/20, height*18/20);
    
    buttons();
    restart();
    
    fill(255);
    textSize(50);
    text("Game Over!", width/2, backY+100);
    
    textSize(30);
    textAlign(CENTER);
    text("Time lasted: " + millis()/1000, width/2, backY + 300);
    text("Dead on wave: NaN", width/2, backY + 350);
  }

  void buttons() {
    back = new AABB(backX, backY, backW, backH, 0, 0);
    overBack = mouseOverButton(back);
    
    if (overBack) {
      fill(255, 200, 0);
    } else {
      fill(255);
    }
    rect(backX, backY, backW, backH);
    
    line(width/20+10, height/20+110, width/20+110, height/20+10);
    line(width/20+10, height/20+10, width/20+110, height/20+110);
  }
  
  void restart(){
    restart = new AABB(restartX, restartY, restartW, restartH, 0, 0);
    overRestart = mouseOverButton(restart);
    
    if(overRestart){
      fill(255, 200, 0);
    } else {
      fill(255);
    }
    rect(restartX, restartY, restartW, restartH);
    
    fill(0);
    noFill();
    arc(restartX + restartW/2, restartY + restartH/2, 50, 50, PI/4, PI*2-PI/4);
    line((restartX + restartW/2) + 8, (restartY + restartH/2) - 12, width*18/20+3, height*2/23+2);
    line(width*18/20+3, height*2/23+2, width*18/20, height/12-6);
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
      } else if (overRestart){
        switchToGame();
      }
    } else if (!mousePressed) {
      prevMouse = false;
    }
  }
}

//CREDITS CLASS---------------------------------------------------
class Credits{
  
  float backX, backY, backW, backH;
  AABB back;
  boolean overBack;
  
  Credits(){
    backX = 25;
    backY = 25;
    backW = 50;
    backH = 50;
  }
  
  void update(){
    buttonPressed();
  }
  
  void draw(){
    background(0, 64, 0);
    fill(255);
    textSize(48);
    textAlign(CENTER);
    text("CREDITS", width/2, 55);
    
    backDrop();
    backButton();
    textBox();
  }
  
  void textBox(){
    textSize(30);
    textAlign(LEFT);
    fill(0);
    text("Ethan Prindle - Towers, Procedural Generation, Primary Bug Fixer,", width/24+10, height*3/24);
    text("Pathfinding",width/24+10, height*3/24 + 40);
    
    text("Lawrence Simons - Enemies",width/24+10, height*3/24 + 80);
    text("",width/24+10, height*3/24 + 120);
    
    text("Jon Miller - Shop, UI elements, RAM and Energy, Main HUD",width/24+10, height*3/24 + 160);
    text("",width/24+10, height*3/24 + 200);
    
    text("Ryk Sacha - Title, Options, Help, and Credits Scenes",width/24+10, height*3/24 + 240);
    text("Screen Animations, Audio",width/24+10, height*3/24 + 280);
    
    text("Music Credits - The Alex Digital Project Alien by Alex Kegler",width/24+10, height*3/24 + 320);
    
    text("Sound Credits - Clicks for Game menu by UniversField",width/24+10, height*3/24 + 360);
  }
  
  void backDrop(){
    fill(78, 156, 0);
    rectMode(CORNER);
    rect(width/24, height*2/24, width*22/24, height*20/24);
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
