void AEkeysMain() {
  AEkeysBegin();
  for (int i=0;i<numParticles;i++) {
    obj += "\t" + "var solid = myComp.layers.addSolid([1.0, 1.0, 0], \"my square\", 50, 50, 1);" + "\r";
    obj += "\t" + "solid.threeDLayer = true;" + "\r";
    if(motionBlur){
      obj += "\t" + "solid.motionBlur = true;" + "\r";
    }
    if(applyEffects){
      AEeffects();
    }
    obj += "\r";
    obj += "\t" + "var p = solid.property(\"position\");" + "\r";
    obj += "\t" + "var r = solid.property(\"rotation\");" + "\r";
    obj += "\r";

    for (int j=0;j<counter;j++) {
      AEkeyPos(i,j);
      AEkeyRot(i,j);
    }
}
    AEkeysEnd();   
}

float AEkeyTime(int frameNum){
  return (float(frameNum)/float(counter)) * (float(counter)/float(fps));
}

void AEkeyPos(int spriteNum, int frameNum){
     // smoothing algorithm by Golan Levin

   PVector lower, upper, centerNum;

     centerNum = (PVector) particle[spriteNum].AEpath.get(frameNum);

     if(applySmoothing && frameNum>smoothNum && frameNum<counter-smoothNum){
       lower = (PVector) particle[spriteNum].AEpath.get(frameNum-smoothNum);
       upper = (PVector) particle[spriteNum].AEpath.get(frameNum+smoothNum);
       centerNum.x = (lower.x + weight*centerNum.x + upper.x)*scaleNum;
       centerNum.y = (lower.y + weight*centerNum.y + upper.y)*scaleNum;
       centerNum.z = (lower.z + weight*centerNum.z + upper.z)*scaleNum;
     }
     
     if(frameNum%smoothNum==0||frameNum==0||frameNum==counter-1){
       obj += "\t\t" + "p.setValueAtTime(" + AEkeyTime(frameNum) + ", [ " + centerNum.x + ", " + centerNum.y + ", " + centerNum.z + "]);" + "\r";
     }
}

void AEkeyRot(int spriteNum, int frameNum){

   float lower, upper, centerNum;

     //note the capitalized Float; this is a quirk of ArrayLists. http://processing.org/discourse/beta/num_1227938522.html
     centerNum = (Float) particle[spriteNum].AErot.get(frameNum);

     if(applySmoothing && frameNum>smoothNum && frameNum<counter-smoothNum){
       lower = (Float) particle[spriteNum].AErot.get(frameNum-smoothNum);
       upper = (Float) particle[spriteNum].AErot.get(frameNum+smoothNum);
       centerNum = (lower + weight*centerNum + upper)*scaleNum;
     }
     
     if(frameNum%smoothNum==0||frameNum==0||frameNum==counter-1){
      obj += "\t\t" + "r.setValueAtTime(" + AEkeyTime(frameNum) + ", " + centerNum +");" + "\r";
     }
}

void AEeffects(){
     obj += "\t" + "var myEffect = solid.property(\"Effects\").addProperty(\"Fast Blur\")(\"Blurriness\").setValue(61);";
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void AEkeysBegin() {
  //dataAE = new Data();
  //dataAE.beginSave();
  obj += "{  //start script" + "\r";
  obj += "\t" + "app.beginUndoGroup(\"foo\");" + "\r";
  obj += "\r";
  obj += "\t" + "// create project if necessary" + "\r";
  obj += "\t" + "var proj = app.project;" + "\r";
  obj += "\t" + "if(!proj) proj = app.newProject();" + "\r";
  obj += "\r";
  obj += "\t" + "// create new comp named 'my comp'" + "\r";
  obj += "\t" + "var compW = " + dW + "; // comp width" + "\r";
  obj += "\t" + "var compH = " + dH + "; // comp height" + "\r";
  obj += "\t" + "var compL = " + (counter/fps) + ";  // comp length (seconds)" + "\r";
  obj += "\t" + "var compRate = " + fps + "; // comp frame rate" + "\r";
  obj += "\t" + "var compBG = [0/255,0/255,0/255] // comp background color" + "\r";
  obj += "\t" + "var myItemCollection = app.project.items;" + "\r";
  obj += "\t" + "var myComp = myItemCollection.addComp('my comp',compW,compH,1,compL,compRate);" + "\r";
  obj += "\t" + "myComp.bgColor = compBG;" + "\r";
  obj += "\r";  
}

void AEkeysEnd() {
  obj += "\r";
  obj += "\t" + "app.endUndoGroup();" + "\r";
  obj += "}  //end script" + "\r";
  //dataAE.endSave(aeFilePath + "/" + aeFileName + "." + aeFileType);
}


