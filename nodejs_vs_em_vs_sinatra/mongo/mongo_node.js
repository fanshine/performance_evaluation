var http = require('http');
var mongoose = require('mongoose'),
   db = mongoose.connect('mongodb://localhost/event-trigger'),
   Schema = mongoose.Schema,
   ObjectId = Schema.ObjectId;

var TestNode = new Schema({
   name      : String
});
var TestNode = mongoose.model('TestNode', TestNode);

var server = http.createServer(function (request, response) {
  new TestNode({name: 'gogogo'}).save(function (err) {
    if(err) console.log(err);
  })

  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("Hello World\n");
})

server.listen(3000);
console.log("Server running at http://127.0.0.1:3000/");



