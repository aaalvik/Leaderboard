module.exports = function (app, db) {
    app.post('/results', (req, res) => {
        const result = { name: req.body.name, score: req.body.score };
        db.collection('results').insert(result, (err, result) => {
            if (err) {
                res.send({ 'error': 'An error has occurred' });
            } else {
                res.send(result.ops[0]);
            }
        })
    });
};