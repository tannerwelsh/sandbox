# Screenplay - Feature Ideas

Concepts:

- Narrative: a sequence of bundled events and state changes played in real time. Example: video plays, transcribed text from video narration is “typed” out in side bar, and workspace is animated with changes to the example being shown.
- Workspace: the area of the app whose state is managed by a narrative. Can be locked (made non-interactive) while in certain modes, otherwise is fully interactive for users. The state of the workspace is managed as a tree of changes (very similar to a git tree).

Modes: three options.
- “Playback” mode is when the narrative is running. In this mode, the workspace is effectively a video for the user - they cannot interact with it. They have access to all the familiar video controls: play/pause, jump navigation, alter playback speed, etc. Users cannot change the state of the workspace while in “Playback” mode
- “Sandbox” mode can be activated by pausing from “playback”. In sandbox mode, the workspace is no longer locked and becomes fully interactive. However, resuming “playback” mode will cause changes made to be lost unless a new branch is created.
- “Checkpoint” mode (needs a new name) is a special case where a user needs to perform certain actions in the workspace to advance. This may involve editing the workspace. Example: having users pass some test or quiz before the narrative will continue.

Features:

- Video playback is sync’d to state of the workspace
- Workspace is fully editable when video is not running
- Users can save their edits as “branches” off of the main narrative
- Users can jump around various waypoints / chapters in the video and the state of the workspace will automatically update
- Should support audio-only and audio-video mixed narratives.
- Narrative should support branching as well, for choose-your-own-adventure type structures
    - I.e. user actions could trigger sub-narratives
- Could this be a live tool? I.e. for a remote classroom, the teacher could be “streaming/recording” their changes, and students could branch off at any time to play with the changes as they come through

UI:

- Should seamlessly transition between modes.
- Can we have full-screen video that fades nicely to a workspace?
- Needs separate sections for:
    - Controlling narrative (play, pause, skip, etc.)
    - Navigating between chapters
    - Workspace
        - may include an “output” section as well as an “editable” section



What other components are needed

Workspace ideas:
- Code editor and console
- Code test runner
- System designer (like the one ncases built)
- Audio editor?
- Circuitry designer
- UML / diagrams
- Math editor / graphing tool
- Board game renderer (chess? Go?)
- Drawing tool
- UI design tool like Figma?

Could we even embed another website as an iframe in the workspace, and record all the events emitted for playback?

## Initial Concept

what if instead of recording videos of a code editor, the code editor _was_ the video, and changes happened in real-time while the audio track played over, and then users could edit / play with the environment right afterwards?

could i use Vuex mutations to make a video showing edits?

then, users could pause, play with the code, and __save__ their edits as a separate “branch” to play with later. so long as we return to the original branch for the “video”, the timeline can continue.