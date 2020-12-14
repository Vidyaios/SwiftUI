//
//  SwiftUICalciView.swift
//  SwiftUICalculator
//
//  Created by Janki Vipulkumar Jariwala on 2020-12-12.
//

import SwiftUI

struct SwiftUICalciView: View {
    @State private var strFirstNum = 0
    @State private var strSecondNum = 0
    @State private var operand = ""
    @State private var calcText = 0.0
    @State private var isTypingNumber = false

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter the number", text: $calcText)
                .padding().multilineTextAlignment(.trailing)
                .border(Color.gray)
                .font(.system(size: 30))
//            HStack {
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
                Button(action: {
                    self.funcClearNumber()
                }) {
                    Text("C")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                }
                Spacer()
                funcCreateCalcDigit("0")
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
        strFirstNum = Int(calcText)!
        self.operand = operand
        calcText = operand
    }
    
    private func funcCalculate() {
        isTypingNumber = false
        var result  = 0
        strSecondNum = Int(calcText)!

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

struct SwiftUICalciView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUICalciView()
    }
}
