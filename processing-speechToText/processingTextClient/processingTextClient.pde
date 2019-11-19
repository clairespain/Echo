/*
  Simple WebSocketServer example that can receive voice transcripts from Chrome
  Requires WebSockets Library: https://github.com/alexandrainst/processing_websockets
 */
import websockets.*;
WebsocketServer socket;
void setup() {
  socket = new WebsocketServer(this, 1337, "/p5websocket");
}
void draw() {
background(0);
}
void webSocketServerEvent(String msg){
println(msg);
}
