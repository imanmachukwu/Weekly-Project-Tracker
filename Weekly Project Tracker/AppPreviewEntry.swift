import SwiftUI

struct PreviewAppEntry: View {
    @State private var hasSeenOnboarding = false

    var body: some View {
        if hasSeenOnboarding {
            ContentView()
                .environmentObject(ProjectData())
        } else {
            OnboardingView(hasFinished: $hasSeenOnboarding)
        }
    }
}

#Preview {
    PreviewAppEntry()
}