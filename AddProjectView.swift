import SwiftUI

struct AddProjectView: View {
    @State private var projectName: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date().addingTimeInterval(7*24*60*60) // One week from now
    @Environment(\.presentationMode) var presentationMode
    var onProjectAdded: (Project) -> Void

    var body: some View {
        Form {
            TextField("Project Name", text: $projectName)
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
            Button("Add Project") {
                let newProject = Project(name: projectName, startDate: startDate, endDate: endDate)
                onProjectAdded(newProject)
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.orange.opacity(0.1))
        }
        .navigationTitle("Add New Project")
    }
}
