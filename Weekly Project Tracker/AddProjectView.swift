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
  DailyGoal(description: dailyGoal1),
  DailyGoal(description: dailyGoal2),
  DailyGoal(description: dailyGoal3),
  DailyGoal(description: dailyGoal4),
  DailyGoal(description: dailyGoal5),
  DailyGoal(description: dailyGoal6),
  DailyGoal(description: dailyGoal7)
  ], color: selectedColor)
  onProjectAdded(newProject)
  presentationMode.wrappedValue.dismiss()
  }
  }
  .navigationTitle("Add New Project")
  }
 }
