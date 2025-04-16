//
 //  ProjectDetailView.swift
 //  Weekly Project Tracker
 //
 //  Created by Imanma's MacBook  on 4/16/25.
 //
 

 import SwiftUI
 

 struct ProjectDetailView: View {
  let project: Project
 

  var body: some View {
  List {
  ForEach(Array(project.dailyGoals.enumerated()), id: \.element.id) { index, goal in
  Text("Day \(index + 1): \(goal.description)")
  }
  }
  .navigationTitle(project.name)
  }
 }
