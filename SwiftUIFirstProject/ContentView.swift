//
//  ContentView.swift
//  SwiftUIFirstProject
//
//  Created by Duaa Bukhari on 18/06/2021.
//

import SwiftUI

struct ContentView: View {
    let labelsNames = ["Price", "Discount", "Result"]
    //Tax is the last number
    @State var inputNames = ["0", "0" ,"0.0" ,"0"]
    
    let buttons = [
        ["7", "8", "9", "Erase"],
        ["4", "5", "6", "C"],
        ["1", "2", "3", "."],
        ["", "0", "", ""]
    ]
    
    let buttonsText = [
        ["7", "8", "9", "⌫"],
        ["4", "5", "6", "C"],
        ["1", "2", "3", "•"],
        ["", "0", "", ""]
    ]
    
    @State var ShouldBeSelected = "Price"
    
    var body: some View {
        ZStack{
            Color("ZStack Background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            //big VStack
            VStack{
                ForEach(0..<3) { TNum in
                    HStack {
                        let anynumber : Int = (TNum == 1 ? 2 : 1)
                        ForEach(0..<anynumber) { TaxFor in
                            VStack(spacing : 0){
                                Text( (TaxFor == 1 ? "Tax" : labelsNames[TNum]) )
                                    .font(.system(size: 22))
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 30/2, alignment: .leading)
                                    .foregroundColor(Color.init(.sRGB, red: 255/255, green: 234/255, blue: 201/255, opacity: 1))
                                    .padding(.leading, 30)
                                    .padding(.bottom, 7)
                                Text( (TaxFor == 1 ? inputNames[TNum + anynumber] + " %" : ( TNum == 1 ? inputNames[TNum] + " %" : inputNames[TNum] + " SAR")) )
                                    .font(.system(size: 32))
                                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                                    .foregroundColor(TNum == 2 ? Color.init(.sRGB, red: 102/255, green: 222/255, blue: 147/255, opacity: 1) : .white)
                                    .background(Color.init(.sRGB, red: 216/255, green: 58/255, blue: 86/255, opacity: 1))
                                    .cornerRadius(16)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.white, lineWidth: ShouldBeSelected == (TaxFor == 1 ? "Tax" : labelsNames[TNum]) ? 3 : 0)
                                        
                                    )
                                    .frame(height: 56)
                                    .padding(.leading, 16).padding(.trailing, 16)
                                    .onTapGesture(count: 1){
                                        if (TaxFor == 1 ? "Tax" : labelsNames[TNum]) != "Result" {
                                            ShouldBeSelected = (TaxFor == 1 ? "Tax" : labelsNames[TNum])
                                        }
                                    }
                                
                            }//small VStack end
                            .padding(.top, 16).padding(.bottom, 16)
                        }//end foreach
                    }//HStack end
                }//foe each end
                
                //bottom HStack
                HStack(spacing : 0){
                    ForEach(0..<4){ Hnum in
                        VStack(spacing : 0){
                            
                            ForEach(0..<4) { Vnum in
                                let clickedButton = (buttons[Vnum])[Hnum]
                                //Button
                                Button(action: {
                                    // C Button
                                    if clickedButton == "C" {
                                        inputNames = ["0", "0", "0" ,"0"]
                                    } else if clickedButton == "Erase" {
                                        // Delete Button
                                        if ShouldBeSelected == "Price" {
                                            //inputNames[0] = inputNames[0].dropLast().description
                                            inputNames[0].removeLast()
                                            if inputNames[0] == "" { inputNames[0] = "0" }
                                        } else if ShouldBeSelected == "Discount" {
                                            inputNames[1].removeLast()
                                            if inputNames[1] == "" { inputNames[1] = "0" }
                                        } else if ShouldBeSelected == "Tax" {
                                            inputNames[3].removeLast()
                                            if inputNames[3] == "" { inputNames[3] = "0" }
                                        }
                                    } else if clickedButton == "." {
                                        // . button
                                        if ShouldBeSelected == "Price" && inputNames[0].contains(".") == false {
                                            inputNames[0] = inputNames[0] + clickedButton
                                        }
                                    } else if clickedButton == "" {
                                        
                                    } else {
                                        
                                        // Numbers Buttons
                                        if ShouldBeSelected == "Price" {
                                            if inputNames[0] == "0" { inputNames[0] = "" }
                                            inputNames[0] = inputNames[0] + clickedButton
                                        } else if ShouldBeSelected == "Discount" {
                                            if inputNames[1] == "0" { inputNames[1] = "" }
                                            if Double(inputNames[1] + clickedButton)! < 101 {
                                                inputNames[1] = inputNames[1] + clickedButton
                                            }
                                        } else if ShouldBeSelected == "Tax" {
                                            if inputNames[3] == "0" { inputNames[3] = "" }
                                            if Double(inputNames[3] + clickedButton)! < 101 {
                                                inputNames[3] = inputNames[3] + clickedButton
                                            }
                                            
                                        }
                                        
                                    }
                                    let Price = Double(inputNames[0])!
                                    let Discount = Double(inputNames[1])!
                                    let Tax = Double(inputNames[3])!
                                    let discountResult = Price - (Price * (Discount / 100))
                                    let discountAndTaxResult = discountResult * ((Tax / 100) + 1)
                                    inputNames[2] = String(format: "%.2f", discountAndTaxResult)
                                }) {
                                    //Attribute
                                    HStack {
                                        Text( (buttonsText[Vnum])[Hnum] )
                                            .font(.system(size: 33))
                                            .bold()
                                            .minimumScaleFactor(0.4)
                                            .lineLimit(1)
                                    }
                                    .foregroundColor(Color.init(.sRGB, red: 216/255, green: 58/255, blue: 86/255, opacity: 1))
                                    .frame(maxWidth : UIScreen.main.bounds.width, maxHeight : UIScreen.main.bounds.height)
                                    .padding(14)
                                }//Button End
                                
                            }//foreach end
                            
                        }//bottom VStack End
                        
                    }//bottom foreach end
                    
                }//bottom HStack End $ bottom stack attributes
                .padding(.bottom, 30)
                .padding(.top, 20)
                .background(Color.white)
                .cornerRadius(40)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
            }//big VStack End
            
        }//ZStack End
        
    }//body end
    
}//view end

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12 Pro")
    }
}
