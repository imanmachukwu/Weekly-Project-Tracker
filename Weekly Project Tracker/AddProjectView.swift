//
 //  AddProjectView.swift
 //  Weekly Project Tracker
 //
 //  Created by Imanma's MacBook  on 4/16/25.
 //
 

 import SwiftUI
 

 struct AddProjectView: View {
  @State private var projectName: String = ""
  @State private var startDate: Date = Date()
  @State private var endDate: Date = Date().addingTimeInterval(7*24*60*60) // One week from now
  @State private var dailyGoal1: String = ""
  @State private var dailyGoal2: String = ""
  @State private var dailyGoal3: String = ""
  @State private var dailyGoal4: String = ""
  @State private var dailyGoal5: String = ""
  @State private var dailyGoal6: String = ""
  @State private var dailyGoal7: String = ""
  @State private var selectedColor: ProjectColor = .red
  @Environment(\.presentationMode) var presentationMode
  @Environment(\.managedObjectContext) private var viewContext
  @EnvironmentObject var projectData: ProjectData
  var onProjectAdded: (Project) -> Void

  var body: some View {
   List {
    Section(header: Text("Project Details")) {
     TextField("Project Name", text: $projectName)
     DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
     DatePicker("End Date", selection: $endDate, displayedComponents: .date)
     Picker("Color", selection: $selectedColor) {
      ForEach(ProjectColor.allCases, id: \.self) { color in
       Text(color.rawValue.capitalized)
      }
     }
    }
    Section(header: Text("Daily Goals")) {
     TextField("Day 1", text: $dailyGoal1)
     TextField("Day 2", text: $dailyGoal2)
     TextField("Day 3", text: $dailyGoal3)
     TextField("Day 4", text: $dailyGoal4)
     TextField("Day 5", text: $dailyGoal5)
     TextField("Day 6", text: $dailyGoal6)
     TextField("Day 7", text: $dailyGoal7)
    }
    Button("Add Project") {
     let newProject = Project(name: projectName, startDate: startDate, endDate: endDate, dailyGoals: [
      DailyGoal(description: dailyGoal1, isCompleted: false),
      DailyGoal(description: dailyGoal2, isCompleted: false),
      DailyGoal(description: dailyGoal3, isCompleted: false),
      DailyGoal(description: dailyGoal4, isCompleted: false),
      DailyGoal(description: dailyGoal5, isCompleted: false),
      DailyGoal(description: dailyGoal6, isCompleted: false),
      DailyGoal(description: dailyGoal7, isCompleted: false)
     ], color: selectedColor)
     projectData.addProject(newProject)
     onProjectAdded(newProject)
     presentationMode.wrappedValue.dismiss()
    }
   }
   .navigationTitle("Add New Project")
  }
 }
