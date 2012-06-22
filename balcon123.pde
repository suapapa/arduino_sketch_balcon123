#include <UsbKeyboard.h>

// Caution! following pins are reserved by UsbKeyboard
// - 2 used as D+
// - 5 used as D-

#define PIN_LED 13

// If the timer isr is corrected
// to not take so long change this to 0.
#define BYPASS_TIMER_ISR 1

void delayMs(unsigned int ms);

// To read press and release of Fedals
#define PIN_FEDAL_1 10
#define PIN_FEDAL_2 11
#define PIN_FEDAL_3 12

#define BIT_FEDAL_1 (1 << 1)
#define BIT_FEDAL_2 (1 << 2)
#define BIT_FEDAL_3 (1 << 3)

uint8_t fedalLast;
uint8_t readFedals(void);

void setup(void)
{
  pinMode(PIN_FEDAL_1, INPUT);
  pinMode(PIN_FEDAL_2, INPUT);
  pinMode(PIN_FEDAL_3, INPUT);
  digitalWrite(PIN_FEDAL_1, HIGH);
  digitalWrite(PIN_FEDAL_2, HIGH);
  digitalWrite(PIN_FEDAL_3, HIGH);

  pinMode(PIN_LED, OUTPUT);
  digitalWrite(PIN_LED, HIGH);

  // wait while all fedals are relesed
  fedalLast = 0;
  do {
    fedalLast = readFedals();
    delayMs(100);
  } while (fedalLast != 0);

#if BYPASS_TIMER_ISR
  // disable timer 0 overflow interrupt (used for millis)
  TIMSK0 &= !(1 << TOIE0); // ++
#endif

  digitalWrite(PIN_LED, LOW);
}

void loop(void)
{
  UsbKeyboard.update();

  digitalWrite(13, !digitalRead(13));

  uint8_t fedalCurr = readFedals();
  uint8_t fedalChanged = fedalLast ^ fedalCurr;
  if (fedalChanged == 0) {
    delayMs(20);
    return;
  }

  if (fedalChanged & BIT_FEDAL_1) {
    if (fedalCurr & BIT_FEDAL_1) {
      UsbKeyboard.sendKeyStroke(KEY_ESC);
      UsbKeyboard.sendKeyStroke(KEY_F1, MOD_CONTROL_LEFT);
    } else {
      UsbKeyboard.sendKeyStroke(KEY_ESC);
    }
  } else if (fedalChanged & BIT_FEDAL_2) {
    if (fedalCurr & BIT_FEDAL_2) {
      UsbKeyboard.sendKeyStroke(KEY_ESC);
      UsbKeyboard.sendKeyStroke(KEY_F2, MOD_CONTROL_LEFT);
    } else {
      UsbKeyboard.sendKeyStroke(KEY_ESC);
    }
  } else if (fedalChanged & BIT_FEDAL_3) {
    if (fedalCurr & BIT_FEDAL_3) {
      UsbKeyboard.sendKeyStroke(KEY_ESC);
      UsbKeyboard.sendKeyStroke(KEY_F2, MOD_CONTROL_LEFT);
    } else {
      UsbKeyboard.sendKeyStroke(KEY_ESC);
    }
  }

  fedalLast = fedalCurr;
  delayMs(20);
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

uint8_t readFedals(void)
{
  uint8_t f = 0;
  f |= digitalRead(PIN_FEDAL_1) == LOW ? BIT_FEDAL_1 : 0;
  f |= digitalRead(PIN_FEDAL_2) == LOW ? BIT_FEDAL_2 : 0;
  f |= digitalRead(PIN_FEDAL_3) == LOW ? BIT_FEDAL_3 : 0;
  return f;
}

/* vim: set sw=2 et: */
