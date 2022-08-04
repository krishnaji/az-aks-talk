// Nodejs express server app
const express = require('express');
const app = express();
const port = process.env.PORT || 8080;


// add get method to app
app.get('/', (req, res) => {
    console.log('get request');
    res.send('Hello World!');
}
);

// Function to get square root of number
function squareRoot() {
    for (let i = 0; i < 100000; i++) {
    console.log(Math.sqrt(i));
}
}

// load the server
app.get('/load', (req, res) => {
    squareRoot();
    res.send('Hello World!');
}
);

// start server
app.listen(port, () => {
console.log(`Server started on port ${port}`);
})

