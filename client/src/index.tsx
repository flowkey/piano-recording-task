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

// REGISTER ERROR OVERLAY
const showErrorOverlay = (err: any) => {
    // must be within function call because that's when the element is defined for sure.
    const ErrorOverlay = customElements.get("vite-error-overlay");
    // don't open outside vite environment
    if (!ErrorOverlay) {
        return;
    }
    console.log(err);
    const overlay = new ErrorOverlay(err);
    document.body.appendChild(overlay);
};

window.addEventListener("error", showErrorOverlay);
window.addEventListener("unhandledrejection", ({ reason }) => showErrorOverlay(reason));
