//
//  ContentView.swift
//  habit_tracker
//
//  Created by Ulia on 2/21/24.
//

import SwiftUI


extension Color {
    static let lightestPink = Color(red: 254/255, green: 218/255, blue: 225/255)
    static let backgroundYellow = Color(red: 255/255, green: 255/255, blue: 232/255)
    static let midnightBlue = Color(red: 22/255, green: 61/255, blue: 106/255)
    static let lightBlue = Color(red: 173/255, green: 231/255, blue: 255/255)
    static let buttonBlue = Color(red: 98/255, green: 179/255, blue: 241/255)
    
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.buttonBlue)
//            .background(configuration.isPressed ? Color.white : Color.pink)
//            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .foregroundColor(.white)
            .cornerRadius(8)
//            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}


struct ContentView: View {
    @State private var newHabitInput: String = ""
    @State private var allHabits: [String] = []
    @State private var mainButton: Bool = false
    @State private var childButton: Bool = false
    
    var body: some View {
        VStack {
            Text("Habit Tracker")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.title)
                .foregroundColor(.midnightBlue)
                .padding()
            
            Spacer()
            
            if mainButton && !allHabits.isEmpty {
                VStack {
                    HStack {
                        Spacer()
                    }
                    
                    ForEach(allHabits, id: \.self) {
                        text in HStack {
                            Text(text)
                                .padding()
                                .frame(width: 300)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.pink, lineWidth: 2)
                                )
                                .padding(10)
                            
                            Button(action: {
                                childButton.toggle()
                            }) {
                                if childButton {
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(.pink)
                                }
                                else {
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(.white)
                                        .background(.pink)
                                        .clipShape(Circle())
                                }
                            }
                        }
                    }
                }
                .padding()
                .background(Color.lightestPink)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.lightestPink, lineWidth: 2)
                )
                .padding()
            }
            
            TextField("New Habit", text: $newHabitInput)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.lightBlue))
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.midnightBlue, lineWidth: 1)
                            .padding()
                )
            
            Button("Add New Habit") {
                mainButton = true
                allHabits.append(newHabitInput)
                newHabitInput = ""
            }
            .buttonStyle(CustomButtonStyle())
            
            Spacer()
        }.background(Color.backgroundYellow)
    }
}

#Preview {
    ContentView()
}
