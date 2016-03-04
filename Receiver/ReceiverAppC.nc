configuration ReceiverAppC{}

implementation{
  components MainC, LedsC;
  components ReceiverC as App;
  components ActiveMessageC;
  components new AMSenderC(AM_PROJB_MSG);
  components new AMReceiverC(AM_PROJB_MSG);

  App.Boot -> MainC.Boot;
  App.Leds -> LedsC.Leds;
  App.Packet -> AMSenderC;
  App.AMPacket -> AMSenderC;
  App.AMSend -> AMSenderC;
  App.RadioControl -> ActiveMessageC;
  App.Receive -> AMReceiverC;
}
