import SwiftUI
 

 struct CalendarView: View {
  let projects: [Project]
  @State private var currentDate: Date = Date()
  
  var body: some View {
  VStack(spacing: 12) {
  let days = ["M", "T", "W", "T", "F", "S", "S"]
  HStack {
  ForEach(days, id: \.self) { day in
  Text(day)
  .font(.subheadline)
  .foregroundColor(.gray)
  .frame(maxWidth: .infinity)
  }
  }
  
  LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
  ForEach(0..<weekdayOffset(), id: \.self) { _ in
  Text("")
  }
  
  ForEach(0..<daysInMonth(), id: \.self) { day in
  let date = getDateFor(day: day)
  ZStack {
  if let project = getProjectForDate(date: date) {
  Circle().fill(project.color.color)
  } else if isToday(date: date) {
  Circle().strokeBorder(Color.gray, lineWidth: 2)
  } else {
  Circle().fill(Color.clear)
  }
  
  Text("\(day + 1)")
  .foregroundColor(isToday(date: date) ? .black : .black)
  }
  .frame(width: 30, height: 30)
  }
  }
  }
  .padding()
  }
  
  func getProjectForDate(date: Date) -> Project? {
  for project in projects {
  if date >= project.startDate && date <= project.endDate {
  return project
  }
  }
  return nil
  }
  
  func daysInMonth() -> Int {
  let calendar = Calendar.current
  let range = calendar.range(of: .day, in: .month, for: currentDate)!
  return range.count
  }
  
  func getDateFor(day: Int) -> Date {
  let calendar = Calendar.current
  let components = calendar.dateComponents([.year, .month], from: currentDate)
  return calendar.date(from: DateComponents(year: components.year, month: components.month, day: day + 1))!
  }
  
  func isToday(date: Date) -> Bool {
  let calendar = Calendar.current
  return calendar.isDate(date, inSameDayAs: Date())
  }
  
  func weekdayOffset() -> Int {
  let calendar = Calendar.current
  let components = calendar.dateComponents([.year, .month], from: currentDate)
  let firstOfMonth = calendar.date(from: components)!
  let weekday = calendar.component(.weekday, from: firstOfMonth)
  let adjusted = (weekday + 5) % 7
  return adjusted
  }
 }
