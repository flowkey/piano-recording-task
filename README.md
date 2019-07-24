# React Piano Task

This repository contains the instruction and codebase for an interview task at [flowkey](https://www.flowkey.com).

*If anything here is unclear or any questions come to your mind, don’t hesitate to contact us - we’re here for you!*

## Instruction

Please push a clone (not a fork!) of this codebase to your Github/Gitlab account and add a Pull Request implementing the following functionality:

**Enable the user of the app to record and replay a sequence of played keys as a "Song".**

### Product requirements
- Provide a button to start/stop recording a sequence of keys played on the Piano UI
- Define a song title when storing a song on stop recording
- Show a list of stored songs with title
- Enable replaying stored songs with a small play button next to the title (with correct timing of replayed keys!)

### Implementation requirements
- Focus on **clean, readable code** and **simplicity**
- Use the `graphql-server` to store and retrieve songs (here more info on [Queries](https://www.apollographql.com/docs/react/essentials/queries/) & [Mutations](https://www.apollographql.com/docs/react/essentials/mutations/))

### Provided Codebase

The codebase consists of:
- a minimal React `piano-app` based on the [react-piano](https://github.com/kevinsqi/react-piano) package
- a `graphql-server` based on [Apollo](https://www.apollographql.com/)

How to run it:
1. Make sure you have a mongodb running on port 27017 (`mongod` in the terminal)
2. Run `npm install` && `npm start` in `graphql-server`
2. Run `npm install` && `npm start` in `piano-app`
