//
//  CalendarView.swift
//  habit_tracker
//
//  Created by Ulia on 2/22/24.
//

import SwiftUI


//extension Color {
//    static let lightestPink = Color(red: 254/255, green: 218/255, blue: 225/255)
//    static let backgroundYellow = Color(red: 255/255, green: 255/255, blue: 232/255)
//    static let midnightBlue = Color(red: 22/255, green: 61/255, blue: 106/255)
//    static let lightBlue = Color(red: 173/255, green: 231/255, blue: 255/255)
//    static let buttonBlue = Color(red: 98/255, green: 179/255, blue: 241/255)
//    
//}

struct CalendarView: View {
    @State private var selectedMonth: Int = 0
    @State private var selectedDate = Date()
//    @EnvironmentObject var habitsManager: HabitsManager
    let days = ["Sun", "Mon", "Tue", "Wed", "Thurs", "Fri", "Sat"]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Habit Tracker")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.midnightBlue)
                    .padding()
                
                Spacer()
                
                HStack {
                    Button {
                        withAnimation {
                            selectedMonth -= 1
                        }
                    } label: {
                        Image(systemName: "lessthan")
                            .foregroundColor(.pink)
                    }
                    
                    Text(selectedDate.fetchMonthYear())
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    
                    
                    Button {
                        withAnimation {
                            selectedMonth += 1
                        }
                    } label: {
                        Image(systemName: "greaterthan")
                            .foregroundColor(.pink)
                    }
                }
                
                HStack {
                    ForEach(days, id:\.self) { day in Text(day)}
                }
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 20) {
                    ForEach(fetchDates()) { value in
                        ZStack {
                            if value.day != -1 {
                                NavigationLink {
                                    DayView()
                                } label: {
                                    Text("\(value.day)")
                                        .foregroundColor(.black)
                                        .fontWeight(.medium)
                                        .background {
                                            ZStack(alignment: .bottom) {
                                                Circle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 70, height: 70)
                                                
                                                if value.date.toString() == Date().toString() { // need to change this if value statement
                                                    Circle()
                                                        .foregroundColor(.blue.opacity(0.3))
                                                        .frame(width: 10, height: 10)
                                                }
                                            }
                                        }
                                }
                            } else {
                                Text("")
                            }
                        }
                        .frame(width: 32, height: 32)
                    }
                    .padding()
                }
                .onChange(of: selectedMonth) { _ in
                    selectedDate = fetchSelectedMonth()
                }
                Spacer()
            }.background(Color.backgroundYellow)
        }
    }
    
    func fetchDates() -> [CalendarDate] {
        let calendar = Calendar.current
        let currMonth = fetchSelectedMonth()
        
        var allDates = currMonth.fetchAllDates().map({ CalendarDate(day: calendar.component(.day, from: $0), date: $0) })
        
        let firstDay = calendar.component(.weekday, from: allDates.first?.date ?? Date())
        
        for _ in 0..<firstDay - 1 {
            allDates.insert(CalendarDate(day: -1, date: Date()), at: 0)
        }
        
        return allDates
    }
    
    func fetchSelectedMonth() -> Date {
        let calendar = Calendar.current
        let month = calendar.date(byAdding: .month, value: selectedMonth, to: Date())!
        return month
    }
}

struct CalendarDate: Identifiable {
    let id = UUID()
    var day: Int
    var date: Date
}

extension Date {
    
    func fetchMonthYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func fetchAllDates() -> [Date] {
        let calendar = Calendar.current
        let currMonth = calendar.component(.month, from: self)
        let currYear = calendar.component(.year, from: self)
        
        var startDateComponents = DateComponents()
        startDateComponents.year = currYear
        startDateComponents.month = currMonth
        startDateComponents.day = 1
        let startDate = calendar.date(from: startDateComponents)!
        
        var endDateComponents = DateComponents()
        endDateComponents.month = 1
        endDateComponents.day = -1
        let endDate = calendar.date(byAdding: endDateComponents, to: startDate)!
        
        var dates: [Date] = []
        var currDate = startDate
        
        while currDate <= endDate {
            dates.append(currDate)
            currDate = calendar.date(byAdding: .day, value: 1, to: currDate)!
        }
        return dates
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
}

#Preview {
    CalendarView()
}
