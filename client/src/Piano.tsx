import React from "react";
import { Piano as ReactPiano, KeyboardShortcuts, MidiNumbers, NoteFunction } from "react-piano";
import "react-piano/dist/styles.css";

const noteRange = {
    first: MidiNumbers.fromNote("c3"),
    last: MidiNumbers.fromNote("f4"),
};

const keyboardShortcuts = KeyboardShortcuts.create({
    firstNote: noteRange.first,
    lastNote: noteRange.last,
    keyboardConfig: KeyboardShortcuts.HOME_ROW,
});

function Piano({ onPlayNote, onStopNote }: { onPlayNote: NoteFunction; onStopNote: NoteFunction }) {
    return (
        <div>
            <ReactPiano
                noteRange={noteRange}
                playNote={onPlayNote}
                stopNote={onStopNote}
                width={1000}
                keyboardShortcuts={keyboardShortcuts}
            />
        </div>
    );
}

export default Piano;
