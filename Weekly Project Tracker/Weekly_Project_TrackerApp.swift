//
 //  Weekly_Project_TrackerApp.swift
 //  Weekly Project Tracker
 //
 //  Created by Imanma's MacBook  on 4/16/25.
 //
 

 import SwiftUI
 

 var immediateGoal: String = ""
 

 @main
 struct WeeklyProjectTrackerApp: App {
  var body: some Scene {
  WindowGroup {
  ContentView()
  }
  }
 }
 

struct ContentView: View {
    @State private var projects: [Project] = []
    @State private var isAddingProject = false
    @State private var gradientStart = UnitPoint.topLeading
    @State private var gradientEnd = UnitPoint.bottomTrailing
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    CalendarView(projects: projects)
                    List {
                        ForEach(projects) { project in
                            HStack {
                                Rectangle()
                                    .fill(project.color.color)
                                    .frame(width: 5)
                                    .cornerRadius(2.5)
                                NavigationLink(destination: ProjectDetailView(project: project)) {
                                    Text(project.name)
                                        .padding(.vertical, 8)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 0)
                .background(Color.clear)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isAddingProject = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            if projects.isEmpty {
                Text("Click the plus button to add a new project")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
        }
    }
}

 #Preview {
  ContentView()
 }
