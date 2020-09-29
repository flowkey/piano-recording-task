declare module "react-piano" {
	export type NoteFunction = (midiNumber: string) => void;

	export class MidiNumbers {
		static fromNote: (noteDescription: string) => number;
	}

	export interface KeyboardShortcutsConfig {}

	export class KeyboardShortcuts {
		// There are more Configs of course
		static HOME_ROW: KeyboardShortcutsConfig;
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
