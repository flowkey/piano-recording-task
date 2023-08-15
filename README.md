# Piano Recording Task

This repository contains the instruction and codebase for an interview task at [flowkey](https://www.flowkey.com).

_If anything here is unclear or any questions come to your mind, don’t hesitate to contact us - we’re here to help you!_

## Task Instructions

1. Please copy this codebase to a private repo on your Github account by clicking [Use this template](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template) on GitHub, or by cloning it manually (don't create a fork!)

2. Add a Pull Request (to merge your changes to `main` of your copy, not this repository!) implementing the following functionality:
   **Allow users of the app to record a sequence of keys played on the Piano UI as a "Song" and replay it.**<br>
   _Please ensure the PR has a clear description explaining the change. You can add screenshots for the reviewer to get a better first impression of the UI._

### Implementation guidelines

- Focus on **clean, readable code** and **simplicity**
- The review will focus on the structure of the React code, and the recording/playback solution you use (storing the recordings in an appropriate data structure will help a lot).
- Use the [server](server) to store and retrieve songs (here the docs for client-side [Queries](https://www.apollographql.com/docs/react/essentials/queries/) & [Mutations](https://www.apollographql.com/docs/react/essentials/mutations/))
- Continue to use `npm` as package manager, don't switch to `yarn`

### Product requirements

- Provide a button to start/stop recording a sequence of keys played on the Piano UI
- Define a song title when storing a song on stop recording
- Show a list of stored songs with title
- Enable replaying stored songs with a small play button next to the title (with correct timing of replayed keys!)

Here a very simple example of what the UI could look like:
<img width="735" alt="image" src="https://user-images.githubusercontent.com/10008938/61955349-1ce49b80-afbb-11e9-810d-108d27c25a2a.png">

_IMPORTANT: It does not have to look like this, that's just an example!_

## Provided Codebase

The codebase consists of:

- a [server](server/README.md) based on [Apollo](https://www.apollographql.com/)
- a minimal React [client](client/README.md) based on the [react-piano](https://github.com/kevinsqi/react-piano) package
- a minimal [Swift UI client](SwiftUI%20Piano%20Recording%20Task/README.md)

Basic infos and how to run instructions for both parts can be found in the according READMEs in each directory.
