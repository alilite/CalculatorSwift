//
//  KeyView.swift
//  Calculator Swift UI
//
//  Created by Ali Bahiraei on 2024-09-22.
//

import SwiftUI

struct KeyView: View {
    @State var value = "0" // @state is used to repaint the UI.
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    @State private var changeColor = false
    let buttons : [[Keys]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    var body: some View {
        VStack{
            
            Spacer() /// we want to to push everything to the bottom of the screen.
            HStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(changeColor ? Color.num:Color.pink.opacity(0.2))
                    .scaleEffect(changeColor ? 1.5 : 1.0)
                    .frame(width: 350, height: 280)
                    .animation(Animation.easeInOut.speed(0.17).repeatForever(), value: changeColor)
                    .onAppear(perform: {
                        // run this code
                        //                    self.blur = 20
                        self.changeColor.toggle()
                    })
                    .overlay(
                        Text(value)
                            .font(.system(size: 100))
                            .foregroundStyle(.black)
                    )
            }.padding()
            ForEach(buttons, id: \.self){
                row in
                HStack(spacing: 12){
                    ForEach(row, id: \.self){
                        element in
                        Button(action: {
                            self.didTap(button: element)
                        }, label: {
                            Text(element.rawValue)
                                .font(.system(size: 30))
                                .frame(width: self.getWidth(element: element), height: self.getheight(element: element))
                                .background(element.buttonColor)
                                .foregroundStyle(.black)
                                .clipShape(RoundedRectangle(cornerRadius: self.getWidth(element: element) / 2))
                            //                               // do not use corner radiurs property,
                                .shadow(color: .purple.opacity(0.5), radius: 30)
                        })
                    }
                }.padding(.bottom, 4)
            }
        }
    }
    
    func didTap(button: Keys){
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
            
            
        case .decimal:
            if !self.value.contains(".") {//decimal calculating 
                self.value += "."
            }
        case .negative:
            if let currentValue = Double(self.value) {
                self.value = "\(currentValue * -1)"
                
            }
        
        case .percent:
            if let currentValue = Double(self.value) {
                self.value = "\(currentValue / 100)"
            }
        
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        
        }
    }
    
    func getWidth(element: Keys) -> CGFloat {
        if element == .zero {
            return (UIScreen.main.bounds.width - (5*10)) / 2
        }
        return (UIScreen.main.bounds.width - (5*10)) / 4
    }
    
    func getheight(element: Keys) -> CGFloat {
        return ((UIScreen.main.bounds.width - (5*10))) / 5
    }
}

#Preview {
    KeyView()
}
