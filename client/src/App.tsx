import React from "react";
import "./App.css";
import Instrument from "./instrument";
import Piano from "./Piano";

function App({ instrument }: { instrument: Instrument }) {
    return (
        <div className="App">
            <h1>React Piano Task</h1>
            <Piano onPlayNote={instrument.playNote} onStopNote={instrument.stopNote} />
        </div>
    );
}

export default App;
