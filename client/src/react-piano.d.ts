// Warning: this is just a "best guess" at the actual types
// If you think they're wrong or something's missing, you're probably right

declare module "react-piano" {
    export type NoteFunction = (midiNumber: string) => void;

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
        disabled?: boolean;
        noteRange: { first: number; last: number };
        playNote?: NoteFunction;
        stopNote?: NoteFunction;
        width: number;
        keyboardShortcuts: KeyboardShortcuts;
    }>;
}
