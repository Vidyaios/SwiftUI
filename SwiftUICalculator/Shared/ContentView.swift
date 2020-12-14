//
//  ContentView.swift
//  Shared
//
//  Created by Janki Vipulkumar Jariwala on 2020-12-12.
//

import SwiftUI

struct ContentView: View {
    @State private var strFirstNum = 0.0
    @State private var strSecondNum = 0.0
    @State private var operand = ""
    @State private var calcText = "0"
    @State private var isTypingNumber = false

    var body: some View {
        Text("SWIFTUI CALCULATOR").bold().font(.system(size: 30)).offset(x: 0, y: -80)
        VStack(alignment: .leading) {
            TextField("Enter the number", text: $calcText)
                .padding().multilineTextAlignment(.trailing)
                .border(Color.gray, width: 3)
                .font(.system(size: 30))
            HStack {
                funcCreateCalcDigit("1")
                Spacer()
                funcCreateCalcDigit("2")
                Spacer()
                funcCreateCalcDigit("3")
                Spacer()
                Button(action: {
                    self.funcSelectOperand("/")
                }) {
                    Text("/")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                }
            }.padding()
            HStack {
                funcCreateCalcDigit("4")
                Spacer()
                funcCreateCalcDigit("5")
                Spacer()
                funcCreateCalcDigit("6")
                Spacer()
                Button(action: {
                    self.funcSelectOperand("*")
                }) {
                    Text("*")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                }
            }.padding()
            HStack {
                funcCreateCalcDigit("7")
                Spacer()
                funcCreateCalcDigit("8")
                Spacer()
                funcCreateCalcDigit("9")
                Spacer()
                Button(action: {
                    self.funcSelectOperand("-")
                }) {
                    Text("-")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                }
            }.padding()
            HStack {
                funcCreateCalcDigit("0")
                Spacer()
                funcCreateCalcDigit(".")
                Spacer()
                Button(action: {
                    self.funcCalculate()
                }) {
                    Text("=")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                }
                Spacer()
                Button(action: {
                    self.funcSelectOperand("+")
                }) {
                    Text("+")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                }
            }.padding()
            HStack {
                Button(action: {
                    self.funcClearNumber()
                }) {
                    Text("AC")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                }
            }.padding()
        }
    }
    
    private func funcCreateCalcDigit(_ number: String) -> Button<Text> {
        return Button(action: {
            self.funcNumberTapped(number)
        }) {
            Text("\(number)")
                .fontWeight(.bold)
                .font(.system(size: 30))
        }
    }

    private func funcNumberTapped(_ number: String) -> Void {
        if isTypingNumber {
            calcText += number
        } else {
            calcText = number
            isTypingNumber = true
        }
    }
    
    private func funcSelectOperand(_ operand: String) {
        isTypingNumber = false
        strFirstNum = Double(calcText)!
        self.operand = operand
        calcText = operand
    }
    
    private func funcCalculate() {
        isTypingNumber = false
        var result  = 0.0
        strSecondNum = Double(calcText)!

        if operand == "/" {
            result = strFirstNum / strSecondNum
        } else if operand == "*" {
            result = strFirstNum * strSecondNum
        } else if operand == "-" {
            result = strFirstNum - strSecondNum
        } else if operand == "+" {
            result = strFirstNum + strSecondNum
        }
        calcText = "\(result)"
    }
    
    private func funcClearNumber() {
        strFirstNum = 0
        strSecondNum = 0
        operand = ""
        calcText = "0"
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
