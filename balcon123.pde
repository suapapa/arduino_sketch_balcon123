#include <UsbKeyboard.h>

// Caution! following pins are reserved by UsbKeyboard
// - 4 used as D- (White)
// - 2 used as D+ (Green)

#define PIN_LED 13

// If the timer isr is corrected
// to not take so long change this to 0.
#define BYPASS_TIMER_ISR 1

void delayMs(unsigned int ms);

// To read press and release of Fedals
#define PIN_TEST    9
#define PIN_FEDAL_1 10
#define PIN_FEDAL_2 11
#define PIN_FEDAL_3 12

#define BIT_TEST    (1 << 0)
#define BIT_FEDAL_1 (1 << 1)
#define BIT_FEDAL_2 (1 << 2)
#define BIT_FEDAL_3 (1 << 3)

uint8_t pedalLast;
uint8_t readFedals(void);

void setup(void)
{
  pinMode(PIN_TEST,    INPUT);
  pinMode(PIN_FEDAL_1, INPUT);
  pinMode(PIN_FEDAL_2, INPUT);
  pinMode(PIN_FEDAL_3, INPUT);
  digitalWrite(PIN_TEST,    HIGH);
  digitalWrite(PIN_FEDAL_1, HIGH);
  digitalWrite(PIN_FEDAL_2, HIGH);
  digitalWrite(PIN_FEDAL_3, HIGH);

  pinMode(PIN_LED, OUTPUT);
  digitalWrite(PIN_LED, HIGH);

  // wait while all pedals are relesed
  pedalLast = 0;
  do {
    pedalLast = readFedals();
    delayMs(100);
  } while (pedalLast != 0);

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

  uint8_t pedalCurr = readFedals();
  uint8_t pedalChanged = pedalLast ^ pedalCurr;
  if (pedalChanged == 0) {
    delayMs(20);
    return;
  }

  if (pedalChanged & BIT_TEST) {
    if (pedalCurr & BIT_TEST) {
      UsbKeyboard.sendKeyStroke(KEY_H);
      UsbKeyboard.sendKeyStroke(KEY_E);
      UsbKeyboard.sendKeyStroke(KEY_L);
      UsbKeyboard.sendKeyStroke(KEY_L);
      UsbKeyboard.sendKeyStroke(KEY_O);
    } else {
      UsbKeyboard.sendKeyStroke(KEY_W);
      UsbKeyboard.sendKeyStroke(KEY_O);
      UsbKeyboard.sendKeyStroke(KEY_R);
      UsbKeyboard.sendKeyStroke(KEY_L);
      UsbKeyboard.sendKeyStroke(KEY_D);
    }
    pedalLast = pedalCurr;
    delayMs(20);
    return;
  }

  UsbKeyboard.sendKeyStroke(KEY_ESC);
  delayMs(20);
  if (pedalChanged & BIT_FEDAL_1) {
    if (pedalCurr & BIT_FEDAL_1) {
      UsbKeyboard.sendKeyStroke(KEY_F2);
      delayMs(20);
    }
  } else if (pedalChanged & BIT_FEDAL_2) {
    if (pedalCurr & BIT_FEDAL_2) {
      UsbKeyboard.sendKeyStroke(KEY_F3);
      delayMs(20);
    }
  } else if (pedalChanged & BIT_FEDAL_3) {
    if (pedalCurr & BIT_FEDAL_3) {
      UsbKeyboard.sendKeyStroke(KEY_F4);
      delayMs(20);
    }
  }

  pedalLast = pedalCurr;
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
  f |= digitalRead(PIN_TEST) == LOW ? BIT_TEST : 0;
  f |= digitalRead(PIN_FEDAL_1) == LOW ? BIT_FEDAL_1 : 0;
  f |= digitalRead(PIN_FEDAL_2) == LOW ? BIT_FEDAL_2 : 0;
  f |= digitalRead(PIN_FEDAL_3) == LOW ? BIT_FEDAL_3 : 0;
  return f;
}

/* vim: set sw=2 et: */
