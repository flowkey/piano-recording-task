import Soundfont from "soundfont-player";

export default class Instrument {
    audioContext: AudioContext;
    activeAudioNodes: Map<number, Soundfont.Player> = new Map();
    soundfont: Soundfont.Player | null = null;

    constructor({
        audioContext,
        format = "mp3",
        soundfont = "MusyngKite",
        instrumentName = "acoustic_grand_piano",
    }: {
        audioContext?: AudioContext;
        format?: "mp3" | "ogg";
        soundfont?: "MusyngKite" | "FluidR3_GM";
        instrumentName?: Soundfont.InstrumentName;
    } = {}) {
        this.audioContext =
            audioContext ||
            new (window.AudioContext ||
                (window as typeof window & { webkitAudioContext: AudioContext })
                    .webkitAudioContext)();

        Soundfont.instrument(this.audioContext, instrumentName, {
            format,
            soundfont,
            nameToUrl: (name: string, soundfont: string, format: string) =>
                `https://d1pzp51pvbm36p.cloudfront.net/${soundfont}/${name}-${format}.js`,
        }).then((soundfont) => {
            this.soundfont = soundfont;
        });
    }

    playNote = (midiNumber: number) => {
        this.audioContext.resume().then(() => {
            if (!this.soundfont) return;

            // the types for soundfont player claim they need a string, but a midi number is fine
            const audioNode = this.soundfont.play(midiNumber as unknown as string);

            this.activeAudioNodes.set(midiNumber, audioNode);
        });
    };

    stopNote = (midiNumber: number) => {
        this.audioContext.resume().then(() => {
            const audioNode = this.activeAudioNodes.get(midiNumber);
            if (!audioNode) return;

            audioNode.stop();
            this.activeAudioNodes.delete(midiNumber);
        });
    };

    // Clear any residual notes that don't get called with stopNote
    stopAllNotes = () => {
        this.audioContext.resume().then(() => {
            this.activeAudioNodes.forEach((node) => node?.stop());
            this.activeAudioNodes.clear();
        });
    };
}
