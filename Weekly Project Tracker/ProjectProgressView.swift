//
//  ProjectProgressView.swift
//  Weekly Project Tracker
//
//  Created by Imanma's MacBook  on 4/16/25.
//


import SwiftUI

struct ProjectProgressView: View {
    let project: Project

    var body: some View {
        VStack {
            Text(project.name)
                .font(.title)
            Text("Start Date: \(project.startDate, formatter: dateFormatter)")
            Text("End Date: \(project.endDate, formatter: dateFormatter)")
            ProgressView(value: calculateProgress())
                .padding(.top)
                .frame(width: 200)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(5)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
    }

    private func calculateProgress() -> Double {
        let currentDate = Date()
        if currentDate < project.startDate {
            return 0.0
        } else if currentDate > project.endDate {
            return 1.0
        } else {
            let totalTime = project.endDate.timeIntervalSince(project.startDate)
            let elapsedTime = currentDate.timeIntervalSince(project.startDate)
            return elapsedTime / totalTime
        }
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}
