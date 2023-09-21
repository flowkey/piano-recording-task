# Piano Recording Task

This repository contains the instruction and codebase for an interview task at [flowkey](https://www.flowkey.com).

_If anything is unclear, don’t hesitate to ask - we’re here to help!_

Please copy this codebase to a private repo on your Github account by clicking [Use this template](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template) on GitHub, or by cloning it manually (don't create a fork!)


## Requirements

1. Record a sequence of keys played on the Piano
   - Ideally recording would be started/stopped via button in the UI
2. Play back the sequence you recorded
   - Consider correct timing
   - Consider polyphony (recording and playing back chords should work, e.g. via hotkeys on the computer's keyboard)
3. Save the recorded sequence to the server (which persists the data in the DB)
   - Prompt the user for the recorded song's title before saving.
4. Retrieve a list of recordings from the server, and allow them to be played back on the client.
   - Add a Play button for each recording

Since our pair programming session is limited in time, don't be discouraged if you don't get to finish everything. That's normal!

If you get totally stuck, consider moving on to a part you feel more familiar with. We're most interested in how you think (and how you communicate your thoughts), and how comfortable you are with the tech stack.

Here is a simple example of what the UI could look like:
<img width="735" alt="image" src="https://user-images.githubusercontent.com/10008938/61955349-1ce49b80-afbb-11e9-810d-108d27c25a2a.png">

_IMPORTANT: The above is not a design blueprint, just an example!_


### Implementation guidelines

- Focus on simplicity as much as possible
- Storing the recordings in an appropriate data structure will help you a lot
- Use the [server](server) to store and retrieve songs
   - Docs: [Queries](https://www.apollographql.com/docs/react/essentials/queries/) - Docs: [Mutations](https://www.apollographql.com/docs/react/essentials/mutations/))


## Provided Codebase

The codebase consists of:

- a [server](server/README.md) based on [Apollo](https://www.apollographql.com/)
- a minimal React [client](client/README.md) based on the [react-piano](https://github.com/kevinsqi/react-piano) package
- a minimal [Swift UI client](SwiftUI%20Piano%20Recording%20Task/README.md)

Basic info and instructions to run can be found in the respective READMEs for each of the parts.
