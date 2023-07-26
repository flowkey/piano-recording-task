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

const mongoClient = mongod
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
        keyStrokes: [Int!]!
    }

    type Query {
        songs: [Song]
    }

    type Mutation {
        addSong(title: String, keyStrokes: [Int]): Song
    }
`;

type GQLContext = { mongo: Awaited<typeof mongoClient> };

const server = new ApolloServer<GQLContext>({
    typeDefs,
    resolvers: {
        Query: {
            async songs(rootValue, args, { mongo }) {
                return [];
            },
        },
        Mutation: {
            async addSong(rootValue, newSong: { title: string; keyStrokes: number[] }, { mongo }) {
                const response = await mongo.collection("songs").insertOne(newSong);
                return { ...newSong, _id: response.insertedId };
            },
        },
    },
});

startStandaloneServer(server, {
    context: async () => ({ mongo: await mongoClient }),
}).then(({ url }) => {
    return console.log(`GraphQL server running: ${url}`);
});
