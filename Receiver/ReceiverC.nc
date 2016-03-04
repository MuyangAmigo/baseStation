#include "Message.h"

module ReceiverC {
  uses {
    interface Boot;
    interface Leds;
    interface Packet;
    interface AMSend;
    interface AMPacket;
    interface Receive;
    interface SplitControl as RadioControl;
  }
}

implementation {
  bool busy;
  message_t pkt;

  event void Boot.booted(){
    busy = FALSE;
    call RadioControl.start();
  }

  event void RadioControl.startDone(error_t err) {
    if (err != SUCCESS) {
      call RadioControl.start();
    }
  }
  event void RadioControl.stopDone(error_t err){}

  event message_t * Receive.receive(message_t* msg, void* payload, uint8_t len){


    if(len != sizeof(ProjB_Msg)) {
      return NULL;
    }

    else {

      ProjB_Msg* rcvPayload = (ProjB_Msg*) payload;


      uint8_t myTemperature = rcvPayload -> Temperature;
      uint16_t myLight = rcvPayload -> Light;

      if (myTemperature > 0x0055) {
        call Leds.led1On();
      }
      else {
        call Leds.led1Off();
      }


      if (myLight < 0x0080) {
        call Leds.led2On();
      }
      else {
        call Leds.led2Off();
      }

    return msg;
    }
  }

  event void AMSend.sendDone(message_t* msg, error_t err) {
    if(&pkt == msg){
      busy = FALSE;
    }
  }
}
