#include <UsbKeyboard.h>

#define PIN_FEDAL_1 3
#define PIN_FEDAL_2 4
#define PIN_FEDAL_3 5

#define PIN_LED 13

// If the timer isr is corrected
// to not take so long change this to 0.
#define BYPASS_TIMER_ISR 1

void setup(void)
{
  pinMode(PIN_FEDAL_1, INPUT);
  pinMode(PIN_FEDAL_2, INPUT);
  pinMode(PIN_FEDAL_3, INPUT);
  digitalWrite(PIN_FEDAL_1, HIGH);
  digitalWrite(PIN_FEDAL_2, HIGH);
  digitalWrite(PIN_FEDAL_3, HIGH);

  pinMode(PIN_LED, OUTPUT);

#if BYPASS_TIMER_ISR
  // disable timer 0 overflow interrupt (used for millis)
  TIMSK0 &= !(1 << TOIE0); // ++
#endif
}

void delayMs(unsigned int ms)
{
#if BYPASS_TIMER_ISR
  for (int i = 0; i < ms; i++)
    delayMicroseconds(1000);
#else
  delay(ms);
#endif
}

void loop(void)
{
  UsbKeyboard.update();

  digitalWrite(13, !digitalRead(13));

  if (digitalRead(PIN_FEDAL_1) == 0) {
    UsbKeyboard.sendKeyStroke(KEY_F1, MOD_CONTROL_LEFT);
    delayMs(20);
  } else if (digitalRead(PIN_FEDAL_2) == 0) {
    UsbKeyboard.sendKeyStroke(KEY_F2, MOD_CONTROL_LEFT);
    delayMs(20);
  } else if (digitalRead(PIN_FEDAL_3) == 0) {
    UsbKeyboard.sendKeyStroke(KEY_F3, MOD_CONTROL_LEFT);
    delayMs(20);
  }
}

/* vim: set sw=2 et: */
