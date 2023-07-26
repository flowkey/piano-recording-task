import gql from "graphql-tag";
import { ApolloServer } from "@apollo/server";
import { startStandaloneServer } from "@apollo/server/standalone";
import { MongoMemoryServer } from "mongodb-memory-server";
import { MongoClient } from "mongodb";

// Don't require a separate MongoDB instance to run
// Note: contents will be wiped when you stop the server
const mongod = new MongoMemoryServer({
    binary: { version: "6.0.8" },
});

// Connect to the local in-memory MongoDB server:
const mongodb = mongod
    .start()
    .then(() => MongoClient.connect(mongod.getUri()))
    .then((connection) => connection.db("graphql"))
    .catch((error) => {
        console.error("Could not connect to MongoDB");
        console.error(error);
        process.exit(1);
    });

// This API is just an example, you can modify any parts if needed for the task
// Be careful with nullability annotations and what that means for security!
const typeDefs = gql`
    type Song {
        _id: ID!
        title: String!
        keyStrokes: [Int]
    }

    type Query {
        songs: [Song!]!
    }

    type Mutation {
        addSong(title: String, keyStrokes: [Int]): Song
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
            { title, keyStrokes }: { title: string; keyStrokes: number[] }
        ) => {
            const newSong = { title, keyStrokes };
            const response = await (await mongodb).collection("songs").insertOne(newSong);

            return { ...newSong, _id: response.insertedId };
        },
    },
};

const server = new ApolloServer({ typeDefs, resolvers });

startStandaloneServer(server).then(({ url }) => {
    console.log(`GraphQL server running: ${url}`);
});
