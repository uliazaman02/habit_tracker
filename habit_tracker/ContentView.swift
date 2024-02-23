//
//  ContentView.swift
//  habit_tracker
//
//  Created by Ulia on 2/21/24.
//

import SwiftUI


extension Color {
    static let lightestPink = Color(red: 234/255, green: 173/255, blue: 221/255)
    static let brightestPink = Color(red: 213/255, green: 82/255, blue: 137/255)
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.pink)
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
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
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
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5.0)
                                        .stroke(Color.pink, lineWidth: 2)
                                )
                            
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
                .background(Color.pink.opacity(0.3))
            }
            
            TextField("New Habit", text: $newHabitInput)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color.lightestPink)
            
            Button("Add New Habit") {
                mainButton = true
                allHabits.append(newHabitInput)
                newHabitInput = ""
            }
            .buttonStyle(CustomButtonStyle())
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
