COMPONENT=ReceiverAppC
BUILD_EXTRA_DEPS+=Receiver.class
CLEAN_EXTRA=*.class Message.java
CFLAGS+=-I$(TOSDIR)/lib/T2Hack
Receiver.class:	$(wildcard *.java)	Message.java
	javac -target	1.4	-source	1.4	*.java
Message.java:
mig java -target=null $(CFLAGS) -java-classname=Message Message.h Temperature_Msg -o $(@)

TINYOS_ROOT_DIR?=../..
include $(TINYOS_ROOT_DIR)/Makefile.include
