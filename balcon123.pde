void setup() {
  pinMode(8, INPUT);

  Keyboard.begin();

}

void loop() {
  delay(50);
  if (digitalRead(8) == LOW) {
    digitalWrite(13, LOW);
  } else {
    digitalWrite(13, HIGH);
    Keyboard.press(KEY_ESC);
    
  }
  Keyboard.releaseAll();

}


