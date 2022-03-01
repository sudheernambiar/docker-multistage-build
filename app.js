const http = require('http');

const server = http.createServer((request, response) => {
        response.write('This is a NodeJs APP\n');
        response.end();
});

server.listen(80, () => {
        console.log('Server is running...');
});
