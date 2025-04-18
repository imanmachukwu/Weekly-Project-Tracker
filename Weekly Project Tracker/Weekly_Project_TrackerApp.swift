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
  @StateObject var projectData = ProjectData()
  
  var body: some Scene {
  WindowGroup {
  ContentView()
  .environmentObject(projectData)
  }
  }
 }
 

struct ContentView: View {
    @EnvironmentObject var projectData: ProjectData
    @State private var isAddingProject = false
    @State private var gradientStart = UnitPoint.topLeading
    @State private var gradientEnd = UnitPoint.bottomTrailing
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    CalendarView(projects: projectData.projects)
                    List {
                        ForEach(projectData.projects) { project in
                            HStack {
                                Rectangle()
                                    .fill(project.color.color)
                                    .frame(width: 5)
                                    .cornerRadius(2.5)
                                NavigationLink(destination: ProjectDetailView(project: project)
                                        .environmentObject(projectData)) {
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
            .sheet(isPresented: $isAddingProject) {
                AddProjectView(onProjectAdded: { project in
                })
                .environmentObject(projectData)
            }
            if projectData.projects.isEmpty {
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
        .environmentObject(ProjectData()) 
 }