module.exports = function (app, db) {
    app.post('/scores', (req, res) => {
        const score = { name: req.body.name, val: req.body.val };
        db.collection('scores').insert(score, (err, result) => {
            if (err) {
                res.send({ 'error': 'An error has occurred' });
            } else {
                res.send(result.ops[0]);
            }
        })
    });
};