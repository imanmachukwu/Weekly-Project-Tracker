import Foundation

struct Secrets {
    static let chatGPTAPIKey = ProcessInfo.processInfo.environment["CHATGPT_API_KEY"] ?? "YOUR_API_KEY"
}
