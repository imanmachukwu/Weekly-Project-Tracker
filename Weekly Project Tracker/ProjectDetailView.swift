//
//  ProjectDetailView.swift
//  Weekly Project Tracker
//
//  Created by Imanma's MacBook  on 4/16/25.
//

import SwiftUI

struct ProjectDetailView: View, Identifiable {
    let project: Project
    @State private var aiResponse: String = "Generating AI overview..."
    let id = UUID()
    @State private var hasGeneratedAIOverview = false

    var body: some View {
        List {
            ForEach(Array(project.dailyGoals.enumerated()), id: \.element.id) { index, goal in
                Text("Day \(index + 1): \(goal.description)")
            }
            Section(header: Text("AI Overview")) {
                Text(aiResponse)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxHeight: .infinity)
        .navigationTitle(project.name)
        .onAppear {
            if !hasGeneratedAIOverview {
                generateAIOverview()
                hasGeneratedAIOverview = true
            }
        }
    }

    func generateAIOverview() {
        let prompt = "Generate a step-by-step plan to achieve the following goal: \(project.name). Consider these daily goals: \(project.dailyGoals.map { $0.description }.joined(separator: ", "))"

        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            aiResponse = "Error: Invalid URL"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(Secrets.chatGPTAPIKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "gpt-4-1106-preview", // this is a valid GPT-4 Turbo model
            "messages": [
                ["role": "system", "content": "You are a helpful assistant that creates step-by-step goal plans."],
                ["role": "user", "content": prompt]
            ],
            "max_tokens": 4000,
            "temperature": 0.5
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                aiResponse = "Error: \(error.localizedDescription)"
                return
            }

            guard let data = data else {
                print("Error: No data received")
                aiResponse = "Error: No data received"
                return
            }

            //print("RAW RESPONSE:\n", String(data: data, encoding: .utf8) ?? "Unable to decode data")

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let firstChoice = choices.first,
                   let message = firstChoice["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    let cleanedContent = content
                        .replacingOccurrences(of: "#", with: "")
                        .replacingOccurrences(of: "*", with: "")
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    DispatchQueue.main.async {
                        aiResponse = cleanedContent
                    }
                } else {
                    print("Error: Could not parse choices from JSON")
                    aiResponse = "Error: Could not parse choices from JSON"
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                aiResponse = "Error: \(error.localizedDescription)"
            }
        }.resume()
    }
}
