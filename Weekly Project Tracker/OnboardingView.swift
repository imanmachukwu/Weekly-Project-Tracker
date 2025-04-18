import SwiftUI

struct OnboardingView: View {
    @Binding var hasFinished: Bool
    @State private var currentPage = 0
    private let numberOfPages = 4

    var body: some View {
        TabView(selection: $currentPage) {
            WelcomeView().tag(0)
            FeaturePageView(pageNumber: 1, featureTitle: "Project Tracking", featureDescription: "Easily track your projects and their deadlines.").tag(1)
            FeaturePageView(pageNumber: 2, featureTitle: "Daily Goals", featureDescription: "Set daily goals for each project to stay on track.").tag(2)
            FeaturePageView(pageNumber: 3, featureTitle: "Calendar View", featureDescription: "Visualize your projects and deadlines in a calendar view.").tag(3)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .onAppear {
            startTimer()
        }
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 7, repeats: true) { timer in
            if currentPage < numberOfPages - 1 {
                currentPage += 1
            } else {
                timer.invalidate()
                hasFinished = true
            }
        }
    }
}

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to Week!")
                .font(.largeTitle)
                .padding()
            Text("Get started managing your projects effectively.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct FeaturePageView: View {
    let pageNumber: Int
    let featureTitle: String
    let featureDescription: String

    var body: some View {
        VStack {
            Text("\(featureTitle)")
                .font(.title)
                .padding()
            Text("\(featureDescription)")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

// #Preview {
//     OnboardingView()
// }
