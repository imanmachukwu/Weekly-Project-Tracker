import Foundation
import SwiftUI

struct DailyGoal: Identifiable, Codable {
    var id = UUID()
    var description: String
    var isCompleted: Bool = false
}

struct Project: Identifiable, Codable {
    var id = UUID()
    var name: String
    var startDate: Date
    var endDate: Date
    var dailyGoals: [DailyGoal] = []
    var color: ProjectColor = .red
    var aiOverview: String? = nil
}

enum ProjectColor: String, CaseIterable, Codable {
    case red, green, blue, yellow, orange, purple, pink

    var color: Color {
        switch self {
        case .red: return .red
        case .green: return .green
        case .blue: return .blue
        case .yellow: return .yellow
        case .orange: return .orange
        case .purple: return .purple
        case .pink: return .pink
        }
    }
}
