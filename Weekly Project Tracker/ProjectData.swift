import SwiftUI

class ProjectData: ObservableObject {
    @Published var projects: [Project] = [] {
        didSet {
            saveProjects()
        }
    }

    init() {
        loadProjects()
    }

    let projectsKey = "ProjectsKey"

    func addProject(_ project: Project) {
        projects.append(project)
    }

    func deleteProject(_ project: Project) {
        projects.removeAll { $0.id == project.id }
    }

    func loadProjects() {
        if let data = UserDefaults.standard.data(forKey: projectsKey) {
            if let decodedProjects = try? JSONDecoder().decode([Project].self, from: data) {
                projects = decodedProjects
            }
        }
    }

    func saveProjects() {
        if let encodedProjects = try? JSONEncoder().encode(projects) {
            UserDefaults.standard.set(encodedProjects, forKey: projectsKey)
        }
    }

    func updateAIOverview(for project: Project, with overview: String) {
        if let index = projects.firstIndex(where: { $0.id == project.id }) {
            projects[index].aiOverview = overview
        }
    }

}
