# graphql-server

This is a simple server implementation to store/retrieve songs using [GraphQL](https://graphql.org/) with [Apollo](https://www.apollographql.com/).

## Run the server
- `npm install`
- `npm start`

## Run sample queries
Start the server & access the [GraphQL Playground IDE](https://github.com/prismagraphql/graphql-playground), e.g. on `localhost:4000`.

To query songs:
```
query {
    songs {
        _id
        title
        keyStrokes
    }
}
```
To add a song:
```
mutation {
    addSong(title: "Some new song", keyStrokes: ["D", "E", "F"]) {
        _id
        title
        keyStrokes
    }
}
```