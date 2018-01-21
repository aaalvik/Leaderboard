var ObjectID = require('mongodb').ObjectID;

module.exports = function (app, db) {
    app.get('/results/:id', (req, res) => {
        const id = req.params.id;
        const details = { '_id': new ObjectID(id) };
        db.collection('results').findOne(details, (err, item) => {
            if (err) {
                res.send({ 'error': 'An error has occurred' });
            } else {
                res.send(item);
            }
        });
    });

    app.delete('/results/:id', (req, res) => {
        const id = req.params.id;
        const details = { '_id': new ObjectID(id) };
        db.collection('results').remove(details, (err, item) => {
            if (err) {
                res.send({ 'error': 'An error has occurred' });
            } else {
                res.send('Note ' + id + ' deleted!');
            }
        });
    })

    app.put('/results/:id', (req, res) => {
        const id = req.params.id;
        const details = { '_id': new ObjectID(id) };
        const newResult = { name: req.body.name, score: req.body.score };
        db.collection('results').update(details, newResult, (err, result) => {
            if (err) {
                res.send({ 'error': 'An error has occurred' });
            } else {
                res.send(newResult);
            }
        });
    });

    app.post('/results', (req, res) => {
        const result = { name: req.body.name, score: req.body.score };
        db.collection('results').insert(result, (err, result) => {
            if (err) {
                res.send({ 'error': 'An error has occurred' });
            } else {
                res.send(result.ops[0]);
            }
        });
    });
};