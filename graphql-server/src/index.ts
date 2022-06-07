import { ApolloServer, gql } from "apollo-server";
import { MongoMemoryServer } from "mongodb-memory-server";
import { MongoClient } from "mongodb";

// Don't require a separate MongoDB instance to run:
const mongod = new MongoMemoryServer();

// Connect to the local mock MongoDB server:
const mongodb = mongod
    .start()
    .then(() => MongoClient.connect(mongod.getUri()))
    .then((connection) => connection.db("graphql"))
    .catch((error) => {
        console.error("Could not connect to MongoDB");
        console.error(error);
        process.exit(1);
    });

// This API is just an example, you can modify any parts if needed for the task:
const typeDefs = gql`
    type Song {
        _id: ID!
        title: String!
        # Careful with nullability!
        keyStrokes: [String]
    }

    type Query {
        songs: [Song!]!
    }

    type Mutation {
        addSong(title: String, keyStrokes: [String]): Song
    }
`;

const resolvers = {
    Query: {
        songs: async () => {
            return (await mongodb).collection("songs").find({}).toArray();
        },
    },
    Mutation: {
        addSong: async (
            _: null,
            { title, keyStrokes }: { title: string; keyStrokes: string[] }
        ) => {
            const newSong = { title, keyStrokes };
            const response = await (await mongodb).collection("songs").insertOne(newSong);

            return { ...newSong, _id: response.insertedId };
        },
    },
};

const server = new ApolloServer({ typeDefs, resolvers });

server.listen().then(({ url }) => {
    console.log(`GraphQL server running: ${url}`);
});
