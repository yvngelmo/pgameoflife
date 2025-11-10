boolean[][] cell = new boolean[50][50];
boolean[][] cellNext = new boolean[50][50];
boolean drawState;
boolean play;
int cellCount33;
void setup()
{
  size(500,500);
  pixelDensity(1);
  strokeWeight(2);
  noSmooth();
  textSize(2);
  textAlign(LEFT,TOP);
  textLeading(2);
}
void draw()
{
  //größere pixel
  scale(10);
  //squares kein stroke
  noStroke();

  //pixel zeichnen, nur wenn nicht play
  if(!play)
    {
    if(mousePressed&&drawState  &&mouseX>0&&mouseX<width&&mouseY>0&&mouseY<height) //und wenn nicht out of bounds gedragged wurde
    {
      cell[mouseX/10][mouseY/10] = true;
    }
    else if(mousePressed&&!drawState  &&mouseX>0&&mouseX<width&&mouseY>0&&mouseY<height) //selbe wie oben
    {
      cell[mouseX/10][mouseY/10] = false;
    }
  }
  
  //cellNext clearen weil sonst janky ka digga
  for (int h=0;h<50;h++)
  {
    for (int w=0;w<50;w++)
    {
      cellNext[w][h]=false;
    }
  }
  
  //algorithmus, werte cellNext speichern damit keine überlappung gibt
  if(play)
  {
    for (int h=0;h<50;h++)
    {
      for (int w=0;w<50;w++)
      {
        //algo nicht auf äußerer rand damit beim neighbor checken nicht out of bounds gesucht wird
        if(w>0&&h>0&&w<49&&h<49)
        {
          //algo start
            
          //zellen zählen
          cellCount33=0;
          
          for (int ch=h-1;ch<h+2;ch++)
          {
            for (int cw=w-1;cw<w+2;cw++)
            {
              if(cell[cw][ch])
              {
                cellCount33++;
              }
            }
          }
          
          //algorithmus für zellen
          if(cell[w][h])
          {
            if(cellCount33>2&&cellCount33<5)
            {
              cellNext[w][h]=true;
            }
          }
          
          //algorithmus für leere
          else
          {
            if(cellCount33==3)
            {
              cellNext[w][h]=true;
            }
          }
        }
      }
    }

    //werte von cellNext in cell einsetzen
    for (int h=0;h<50;h++)
    {
      for (int w=0;w<50;w++)
      {
        cell[w][h]=cellNext[w][h];
      }
    }
  }

  //pixel drawen
  for (int h=0;h<50;h++)
  {
    for (int w=0;w<50;w++)
    {
      //algo pixel
      if (cell[w][h])
      {
        fill(200);
        rect(w,h,1,1);
      }
      else
      {
        fill(100);
        rect(w,h,1,1);
      }
    }
  }

  //außenrand der nich geht wegen out of bounds gefahr + infotext
  noFill();
  stroke(100);
  rect(0, 0, 50, 50);
  fill(0);
  text("space,backspace,r\nplaying="+play,0,0);
}

//maus erase wenn true, draw wenn false
void mousePressed()
{
  if(cell[mouseX/10][mouseY/10] == drawState)
  {
    drawState=!drawState;
  }
}

//start // stopp // screenclear // stopp wenn play & screenclear
void keyPressed()
{
  if(key==' '&&!play)
  {
    play=true;
  }
  else if(key==' '&&play)
  {
    play=false;
  }
  else if(keyCode==BACKSPACE)
  {
    for (int w=0;w<50;w++)
    {
      for (int h=0;h<50;h++)
      {
        cell[w][h]=false;
      }
    }
    play=false;
  }
  else if(key=='r')
  {
    for (int w=0;w<50;w++)
    {
      for (int h=0;h<50;h++)
      {
        cell[w][h]=random(2)>1;
        play=false;
      }
    }
  }
}
