const boardRoutes = require('./board_routes');

module.exports = function (app, db) {
    boardRoutes(app, db);
    // Other route groups could go here, in the future
};