
    const express = require('express');
    const app = express();



    app.get('/players', function (req, res) {
        res.header("Access-Control-Allow-Origin", "*");
        res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
        res.header("Content-Type", "application/json; charset=utf-8");
        res.send(JSON.parse(JSON.stringify(data)));
    });
  


    app.listen(4000, function () {
    console.log('Listening on port 4000!');
    });


  let data = {
   players: [
      { id: "1", name: "Sally", level: 2 },
      { id: "2", name: "Lance", level: 1 },
      { id: "3", name: "Aki", level: 3 },
      { id: "4", name: "Maria", level: 4 },
      { id: "5", name: "Julian", level: 1 },
      { id: "6", name: "Jaime", level: 1 }
    ]
  }
