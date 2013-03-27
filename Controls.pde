void keyPressed(){
/*
 if(key==' '){
   record = !record;
   firstRun = false;
 }
*/
  if(key=='l' || key=='L') useLeap = !useLeap;

  if(key==' '){
  	if(!record & firstRun) obj = "";
    record = !record;
    firstRun=false;
  }
}

void mousePressed() {
  //
}
