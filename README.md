# React Piano Task

Build a small piano application that can play sounds, as well as store and retrieve sequences of played keys from a local GraphQL server.

*If anything here is unclear or any questions come to your mind, don’t hesitate to contact us - we’re here for you!*

### Implementation instructions

- Focus on **clean, readable Code** and **Simplicity**
- Use React for the Frontend
- Use GraphQL for communication with the server
- A starting point for the GraphQL server is given below with the [Apollo Server](#apollo-server)
- You can use the given [Piano Sounds](#piano-sounds) files or any of your choice

### Minimum requirements

- Clickable black and white keys, which play a sound when clicked
- A "Start Song" button to start recording a sequence of keys
- A "Store Song" button to stop recording a sequence of keys and send it to the apollo server
- Enter a song title on pressing "Store Song"
- A list of stored songs with title

### Optional features

- Visual feedback on touching the keys
- Correct piano tone scales
- Replaying stored songs

## Apollo Server

The `apollo-server` directory contains a sample GraphQL server implementation using [Apollo](https://www.apollographql.com/).

### Run the server
- `cd apollo-server` and `npm install`
- `npm start`

### Run sample queries:
Start the server & access the [GraphQL Playground IDE](https://github.com/prismagraphql/graphql-playground), e.g. on `localhost:4000`.

To query songs:
```
query {
    songs {
        id
        title
        keysPlayed
    }
}
```
To add a song:
```
mutation {
    addSong(title: "Some new song", keysPlayed: ["D", "E", "F"]) {
        title
        keysPlayed
    }
}
```

## Piano Sounds

The directory `grand-piano-mp3-sounds` contains sample sounds you can use for this task. Alternatively you can use sounds from `https://github.com/pffy/mp3-piano-sound` or other sample sounds of your preference.
