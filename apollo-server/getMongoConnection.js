const { MongoClient } = require("mongodb");

const mongoUrl = "mongodb://localhost:27017";
const dbName = "graphqldb";

let mongodb = null;

const getMongoConnection = async () => {
    if (!mongodb) {
        try {
            const connection = await MongoClient.connect(mongoUrl, { useNewUrlParser: true });
            mongodb = connection.db(dbName);

            console.log("successfully connected to mongodb");
        } catch (e) {
            console.error(e);
            throw(e);
        }
    }

    return mongodb;
}

module.exports = getMongoConnection;
