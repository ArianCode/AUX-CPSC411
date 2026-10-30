# AUX — CPSC 411 Milestone 1

A standalone, native UIKit version of AUX's personal music collection workflow. This folder is the complete milestone project. The full React Native app and NestJS server elsewhere in the repository are not needed to run it.

## Run

1. Open `AUXMilestone1.xcodeproj` in Xcode.
2. Select the **AUXMilestone1** scheme and an iPhone simulator.
3. Press **Run** (Command-R).

Built with Xcode 26.3; deployment target iOS 16.0. No CocoaPods, npm, API keys, network requests, or package installation are required. Running on a physical iPhone may require selecting your own signing team.

## Submission contents

- `AUXMilestone1.xcodeproj/`: Complete Xcode project and shared scheme.
- `AUXMilestone1/`: App entry point, model, shared UI helpers, and four view controllers.
- `PROJECT_DESCRIPTION.md`: Application description, screen list, navigation diagram, and screenshots.
- `Screenshots/`: Actual simulator captures of each major screen.
- `AUXMilestone1UITests/`: Navigation and in-memory add/edit verification. Run with Command-U.

## Scope

Home → My Rankings → Song Detail → Edit Song, with Add Song reachable from Home or My Rankings. The collection starts with six sample songs. Saving changes updates memory for the current run, and songs are sorted by their displayed rating. Relaunching resets the sample data.

The milestone omits social feeds, friend profiles, taste matching, global rankings, music catalog APIs, audio playback, authentication, persistent storage, and head-to-head ranking logic. Add and Edit use the same form; the app has four distinct screen types.

## Verification

Verified on October 30, 2026 with Xcode 26.3 and an iPhone 17 Pro simulator running iOS 26.3. The app built successfully and the UI workflow test passed with zero failures, covering list/detail navigation, editing a song, rejecting missing required fields, and adding a song. The five included screenshots were exported from that passing run and visually checked.

## GitHub hand-in

The assignment requires the complete Xcode project in GitHub. Upload this entire folder to your course submission repository, including the project file, Swift files, project description, and screenshots. Share that repository link with your instructor. Nothing in this folder requires uploading the full AUX app or its backend. This local preparation does not publish a repository or submit coursework.
