//
//  CalendarView.swift
//  habit_tracker
//
//  Created by Ulia on 2/22/24.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedMonth: Int = 1
    let days = ["Sun", "Mon", "Tue", "Wed", "Thurs", "Fri", "Sat"]
    
    var body: some View {
        HStack {
            Button {
                //action
            } label: {
                Image(systemName: "lessthan")
                    .foregroundColor(.pink)
            }
            
            Text("Month Year")
//            let month = fetchSelectedMonth()
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MMMM yyyy"
//            let formattedHeader = dateFormatter.string(from: month)
//            Text("\(formattedHeader)")
            
            Button {
                //action
            } label: {
                Image(systemName: "greaterthan")
                    .foregroundColor(.pink)
            }
        }
        
        HStack {
            ForEach(days, id:\.self) { day in Text(day)}
        }
        
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(fetchDates()) { value in 
                Text("\(value.day)")
            }
        }
    }
    
    func fetchDates() -> [CalendarDate] {
        let calendar = Calendar.current
        let currMonth = fetchSelectedMonth()
        
        var allDates = currMonth.fetchAllDates().map({ CalendarDate(day: calendar.component(.day, from: $0), date: $0) })
        
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
}

#Preview {
    CalendarView()
}
