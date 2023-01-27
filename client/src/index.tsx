import React from "react";
import { createRoot } from "react-dom/client";
import { ApolloProvider, InMemoryCache, ApolloClient } from "@apollo/client";

import "./index.css";
import App from "./App";
import Instrument from "./instrument";

const piano = new Instrument();

const apolloClient = new ApolloClient({
    uri: "http://localhost:4000",
    cache: new InMemoryCache(),
});

const root = createRoot(document.getElementById("root")!);

root.render(
    <ApolloProvider client={apolloClient}>
        <App instrument={piano} />
    </ApolloProvider>
);
