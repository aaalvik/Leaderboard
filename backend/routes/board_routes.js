var ObjectID = require('mongodb').ObjectID;

module.exports = function (app, db) {


    // Get one score item with given id
    app.get('/scores/:id', (req, res) => {
        const id = req.params.id;
        const details = { '_id': new ObjectID(id) };
        db.collection('scores').findOne(details, (err, item) => {
            if (err) {
                res.send({ 'error': 'An error has occurred' });
            } else {
                res.send(item);
            }
        });
    });

    // Get all saved scores
    app.get('/scores', (req, res) => {
        db.collection('scores').find({}).toArray((err, item) => {
            if (err) {
                res.send({ 'error': 'An error has occurred' });
            } else {
                res.json(item);
            };
        });
    });

    // Delete scoreItem with given id
    app.delete('/scores/:id', (req, res) => {
        const id = req.params.id;
        const details = { '_id': new ObjectID(id) };
        db.collection('scores').remove(details, (err, item) => {
            if (err) {
                res.send({ 'error': 'An error has occurred' });
            } else {
                res.send('Score item ' + id + ' deleted!');
            }
        });
    })

    // Change score item with given id
    app.put('/scores/:id', (req, res) => {
        const id = req.params.id;
        const details = { '_id': new ObjectID(id) };
        const newScore = { name: req.body.name, score: req.body.score };

        db.collection('scores').update(details, newScore, (err, item) => {
            if (err) {
                res.send({ 'error': 'An error has occurred' });
            } else {
                res.send(newScore);
            }
        });
    });

    // Insert new score item
    app.post('/scores', (req, res) => {
        const scoreItem = { name: req.body.name, score: req.body.score };
        db.collection('scores').insert(scoreItem, (err, item) => {
            if (err) {
                res.send({ 'error': 'An error has occurred' });
            } else {
                res.send(item.ops[0]);
            }
        });
    });
};