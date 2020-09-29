import React from "react";
import Soundfont from "soundfont-player";
import { NoteFunction } from "react-piano";

type Unwrapped<T> = T extends Promise<infer U> ? U : T;

interface SoundfontProviderProps {
    audioContext: AudioContext;
    render: ({
        isLoading,
        playNote,
        stopNote,
        stopAllNotes,
    }: {
        isLoading: boolean;
        playNote: NoteFunction;
        stopNote: NoteFunction;
        stopAllNotes: () => void;
    }) => React.ReactNode;

    hostname: string;
    format: "mp3" | "ogg";
    soundfont: "MusyngKite" | "FluidR3_GM";
    instrumentName: Soundfont.InstrumentName;
}

interface SoundfontProviderState {
    instrument: Unwrapped<ReturnType<typeof Soundfont.instrument>> | null;
    activeAudioNodes: { [midiNumber: string]: AudioBufferSourceNode };
}

class SoundfontProvider extends React.Component<SoundfontProviderProps, SoundfontProviderState> {
    static defaultProps = {
        format: "mp3",
        soundfont: "MusyngKite",
        instrumentName: "acoustic_grand_piano",
    };

    state: SoundfontProviderState = {
        activeAudioNodes: {},
        instrument: null,
    };

    componentDidMount() {
        this.loadInstrument(this.props.instrumentName);
    }

    componentDidUpdate(prevProps: SoundfontProviderProps) {
        if (prevProps.instrumentName !== this.props.instrumentName) {
            this.loadInstrument(this.props.instrumentName);
        }
    }

    loadInstrument = (instrumentName: Soundfont.InstrumentName) => {
        // Re-trigger loading state
        this.setState({ instrument: null });

        Soundfont.instrument(this.props.audioContext, instrumentName, {
            format: this.props.format,
            soundfont: this.props.soundfont,
            nameToUrl: (name: string, soundfont: string, format: string) =>
                `${this.props.hostname}/${soundfont}/${name}-${format}.js`,
        }).then((instrument) => {
            this.setState({ instrument });
        });
    };

    playNote = (midiNumber: string) => {
        this.props.audioContext.resume().then(() => {
            if (!this.state.instrument) return;
            const audioNode = this.state.instrument.play(midiNumber);
            this.setState({
                activeAudioNodes: Object.assign({}, this.state.activeAudioNodes, {
                    [midiNumber]: audioNode,
                }),
            });
        });
    };

    stopNote = (midiNumber: string) => {
        this.props.audioContext.resume().then(() => {
            if (!this.state.activeAudioNodes[midiNumber]) {
                return;
            }
            const audioNode = this.state.activeAudioNodes[midiNumber];
            audioNode.stop();
            this.setState({
                activeAudioNodes: Object.assign({}, this.state.activeAudioNodes, {
                    [midiNumber]: null,
                }),
            });
        });
    };

    // Clear any residual notes that don't get called with stopNote
    stopAllNotes = () => {
        this.props.audioContext.resume().then(() => {
            Object.values(this.state.activeAudioNodes).forEach((node) => node?.stop());
            this.setState({ activeAudioNodes: {} });
        });
    };

    render() {
        return this.props.render({
            isLoading: !this.state.instrument,
            playNote: this.playNote,
            stopNote: this.stopNote,
            stopAllNotes: this.stopAllNotes,
        });
    }
}

export default SoundfontProvider;
