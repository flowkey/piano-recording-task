# Piano Recording Task

This repository contains the instruction and codebase for an interview task at [flowkey](https://www.flowkey.com).

*If anything here is unclear or any questions come to your mind, don’t hesitate to contact us - we’re here to help you!*

## Task Instruction

1. Please copy this codebase to your Github/Gitlab account using [Github Importer](https://help.github.com/en/articles/importing-a-repository-with-github-importer) / [Gitlab Importer](https://docs.gitlab.com/ee/user/project/import/repo_by_url.html) or by cloning it (don't create a fork!). Your copy of this repository can either be public repository with a different name or a private one which you will share with your interviewer.


2. Add a Pull Request (to merge your changes to `master` of your copy, not this repository!) implementing the following functionality:
**Enable the user of the app to record a sequence of keys played on the Piano UI as a "Song" and replay it.**

### Implementation guidelines
- Focus on **clean, readable code** and **simplicity**
- Use the [graphql-server](graphql-server) to store and retrieve songs (here the docs for client-side [Queries](https://www.apollographql.com/docs/react/essentials/queries/) & [Mutations](https://www.apollographql.com/docs/react/essentials/mutations/))
- Continue to use `npm` as package manager, don't switch to `yarn`

### Product requirements
- Provide a button to start/stop recording a sequence of keys played on the Piano UI
- Define a song title when storing a song on stop recording
- Show a list of stored songs with title
- Enable replaying stored songs with a small play button next to the title (with correct timing of replayed keys!)

Here a very simple example of what the UI could look like:
<img width="735" alt="image" src="https://user-images.githubusercontent.com/10008938/61955349-1ce49b80-afbb-11e9-810d-108d27c25a2a.png">

*IMPORTANT: It does not have to look like this, that's just an example!*

## Provided Codebase

The codebase consists of:
- a minimal React [piano-app](piano-app) based on the [react-piano](https://github.com/kevinsqi/react-piano) package
- a [graphql-server](graphql-server) based on [Apollo](https://www.apollographql.com/)

Basic infos and how to run instructions for both parts can be found in the according READMEs in each directory.
