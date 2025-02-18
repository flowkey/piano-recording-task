// Warning: this is just a "best guess" at the actual types
// If you think they're wrong or something's missing, you're probably right

declare module "react-piano" {
    export type NoteFunction = (midiNumber: number) => void;

    export class MidiNumbers {
        static fromNote: (noteDescription: string) => number;
    }

    export type KeyboardShortcutsConfig = Readonly<
        { natural: string; flat: string; sharp: string }[]
    >;

    export class KeyboardShortcuts {
        // There are more Configs of course
        static HOME_ROW: KeyboardShortcutsConfig;
        static BOTTOM_ROW: KeyboardShortcutsConfig;
        static QWERTY_ROW: KeyboardShortcutsConfig;

        static create({
            firstNote,
            lastNote,
            keyboardConfig,
        }: {
            firstNote: number;
            lastNote: number;
            keyboardConfig: KeyboardShortcutsConfig;
        }): KeyboardShortcuts;
    }

    export const Piano: import("react").FC<{
        width: number;
        keyboardShortcuts: KeyboardShortcuts;

        /** Determines which keys are available */
        noteRange: { first: number; last: number };

        /** Disable user input */
        disabled?: boolean;

        /** Programatically change which notes are being played (also visually) */
        activeNotes?: number[];

        /** The function called whenever a note is played (including by manipulating `activeNotes`) */
        playNote?: NoteFunction;

        /** The function called whenever a note is stopped (including by manipulating `activeNotes`) */
        stopNote?: NoteFunction;

        /** Also has prevActiveNotes: number[] as a second parameter, but it's recommended to use it */
        onPlayNoteInput?: NoteFunction;

        /** Also has prevActiveNotes: number[] as a second parameter, but it's recommended to use it */
        onStopNoteInput?: NoteFunction;
    }>;
}
