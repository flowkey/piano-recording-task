# React Piano Task

Build a small piano application that can play sounds, as well as store and retrieve sequences of played keys.

*If anything here is unclear or any questions come to your mind, don’t hesitate to contact us - we’re here for you!*

### Implementation instructions

- Focus on **clean, readable Code** and **Simplicity**
- Use **React** for the Frontend
- You can use the given [Piano Sounds](#piano-sounds) files or any of your choice

### Minimum requirements

- Piano:
    - Clickable black and white keys, which play a sound when clicked
    - Visual feedback on touching the keys
- Store song (sequence of keys):
    - Show buttons to start/stop recording a sequence of keys
    - Enable defining a song title
    - Show a list of stored songs with title

### Optional features

- Enable replaying stored songs
- Store and retrieve the songs from a **GraphQL** server instead of from a local array (server given here: [Apollo Server](#apollo-server))

## Piano Sounds

The directory `grand-piano-mp3-sounds` contains sample sounds you can use for this task. Alternatively you can use sounds from `https://github.com/pffy/mp3-piano-sound` or other sample sounds of your preference.

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