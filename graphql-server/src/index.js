const { ApolloServer, gql } = require("apollo-server");
const { MongoMemoryServer } = require("mongodb-memory-server");
const getMongoConnection = require("./getMongoConnection");

// don't require a seperate mongodb instance to run
new MongoMemoryServer({ instance: { port: 27017 } });

const typeDefs = gql`
    type Song {
        _id: ID!
        title: String
        keyStrokes: [String]
    }

    type Query {
        songs: [Song]
    }

    type Mutation {
        addSong(title: String, keyStrokes: [String]): Song
    }
`;

const resolvers = {
    Query: {
        songs: async () => {
            const mongodb = await getMongoConnection();
            return mongodb
                .collection("songs")
                .find({})
                .toArray();
        },
    },
    Mutation: {
        addSong: async (_, { title, keyStrokes }) => {
            const mongodb = await getMongoConnection();
            try {
                const response = await mongodb.collection("songs").insertOne({ title, keyStrokes });
                return mongodb.collection("songs").findOne({ _id: response.insertedId });
            } catch (e) {
                console.error(e);
                throw e;
            }
        },
    },
};

const server = new ApolloServer({ typeDefs, resolvers });

server.listen().then(({ url }) => {
    console.log(`GraphQL server running: ${url}`);
});
