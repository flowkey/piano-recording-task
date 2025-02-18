# graphql-server

This is a simple server implementation to store/retrieve songs using [GraphQL](https://graphql.org/) with [Apollo](https://www.apollographql.com/).

## Run the server

-   `npm install`
-   `npm start`

## Linting

This repo contains a basic linting setup using [eslint](https://eslint.org/) and [prettier](https://prettier.io/).
You can setup your editor to show (and auto-fix on save) linting errors, e.g. using the [VS Code ESLint extension](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint).

You can also run:

-   `npm run eslint` to show linting errors
-   `npm run eslint-fix` to auto-fix linting errors

## Run sample queries

Start the server & access the [GraphQL Playground IDE](https://github.com/prismagraphql/graphql-playground), e.g. on `localhost:4000`.

_IMPORTANT_: This is just a sample API, you will probably need to modify it.

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
    addSong(title: "Some new song", keyStrokes: [51, 52, 53]) {
        _id
        title
        keyStrokes
    }
}
```
