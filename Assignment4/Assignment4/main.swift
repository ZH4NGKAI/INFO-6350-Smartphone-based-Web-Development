//
//  main.swift
//  Assignment4
//
//  Created by mac on 2/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

//class and struct statement
//function
func InitData(){
    let c1 = Customer(name:"Kai", email:"kai@gmail.com")
    let c2 = Customer(name:"Shuyuan", email:"shuyaun@gmail.com")
    let c3 = Customer(name:"Bochao", email:"bochao@gmail.com")
    let c4 = Customer(name:"Hongji", email:"hongji@gmail.com")
    CustomerList.append(c1)
    CustomerList.append(c2)
    CustomerList.append(c3)
    CustomerList.append(c4)
    
    let m1 = Music(name:"Music1", artist: "AA", price: 9.99, quantity:11)
    let m2 = Music(name:"Music2", artist: "BB", price: 19.99, quantity:9)
    let m3 = Music(name:"Music3", artist: "CC", price: 29.99, quantity:7)
    let m4 = Music(name:"Music4", artist: "DD", price: 39.99, quantity:5)
    let m5 = Music(name:"Music5", artist: "EE", price: 49.99, quantity:3)

    MusicList.append(m1)
    MusicList.append(m2)
    MusicList.append(m3)
    MusicList.append(m4)
    MusicList.append(m5)
}


func MusicRentalSystem(){
    print("Welcome to Music Rental Application. Please type the number to select function:")
    print("1.Add Customer")
    print("2.Delete Customer")
    print("3.Display All Customers")
    print("4.Add Musics")
    print("5.Update Music Details")
    print("6.View all available Musics")
    print("7.Search music")
    print("8.Create a Music Order for specific customer")
    print("9.Delete Orders")
    print("10.View all Order")
    print("0.Exit")
}

//command line application
InitData()

SystemLabel : while (true) {
    MusicRentalSystem()
    guard let option: String = readLine() ,!option.isEmpty else {
        print("Please select one option!")
        continue
    }
    
    switch option{
    case "1" :
        AddCustomerLabel: while(true){
            AddCustomer()
            var choice: String = "no"
            OptionLabel: while(true){
                print("Continue(yes), Back to Main Menu(back) or Quit(no) \n")
                guard let choiceStr: String = readLine() ,!choiceStr.isEmpty else {
                    print("Please select one option!")
                    continue OptionLabel
                }
                choice = choiceStr
                break OptionLabel
            }
            if(choice == "yes"){
                continue AddCustomerLabel
            }else if(choice == "back"){
                break AddCustomerLabel
            }else if(choice == "no"){
                exit(0)
            }
        }
    case "2" :
        DeleteCustomerLabel: while(true){
            DeleteCustomer()
            var choice: String = "no"
            OptionLabel: while(true){
                print("Continue(yes), Back to Main Menu(back) or Quit(no) \n")
                guard let choiceStr: String = readLine() ,!choiceStr.isEmpty else {
                    print("Please select one option!")
                    continue OptionLabel
                }
                choice = choiceStr
                break OptionLabel
            }
            if(choice == "yes"){
                continue DeleteCustomerLabel
            }else if(choice == "back"){
                break DeleteCustomerLabel
            }else if(choice == "no"){
                exit(0)
            }
        }
    case "3" :
        DisplayAllCustomers()
        MainMenuLabel: while(true){
        print("Back to main menu(yes) or quit(no) \n")
        guard let choiceStr: String = readLine() ,!choiceStr.isEmpty else {
            print("Please select one option!")
            continue MainMenuLabel
        }
            if(choiceStr == "yes"){
                break MainMenuLabel
            }else{
                exit(0)
            }
    }
    case "4" :
        AddMusicLabel: while(true){
            AddMusic()
            var choice: String = "no"
            OptionLabel: while(true){
                print("Continue(yes), Back to Main Menu(back) or Quit(no) \n")
                guard let choiceStr: String = readLine() ,!choiceStr.isEmpty else {
                    print("Please select one option!")
                    continue OptionLabel
                }
                choice = choiceStr
                break OptionLabel
            }
            if(choice == "yes"){
                continue AddMusicLabel
            }else if(choice == "back"){
                break AddMusicLabel
            }else if(choice == "no"){
                exit(0)
            }
        }
    case "5":
        UpdateMusicLabel: while(true){
            UpdateMusicDetails()
            var choice: String = "no"
            OptionLabel: while(true){
                print("Continue(yes), Back to Main Menu(back) or Quit(no) \n")
                guard let choiceStr: String = readLine() ,!choiceStr.isEmpty else {
                    print("Please select one option!")
                    continue OptionLabel
                }
                choice = choiceStr
                break OptionLabel
            }
            if(choice == "yes"){
                continue UpdateMusicLabel
            }else if(choice == "back"){
                break UpdateMusicLabel
            }else if(choice == "no"){
                exit(0)
            }
        }
    case "6":
        ViewAvaiMusics()
        ViewAvaiMusicsLabel: while(true){
            print("Back to main menu(yes) or quit(no) \n")
            guard let choiceStr: String = readLine() ,!choiceStr.isEmpty else {
                print("Please select one option!")
                continue ViewAvaiMusicsLabel
            }
            if(choiceStr == "yes"){
                break ViewAvaiMusicsLabel
            }else{
                exit(0)
            }
        }
    case "7":
        SearchMusicLabel: while(true){
            UpdateMusicDetails()
            var choice: String = "no"
            OptionLabel: while(true){
                print("Continue(yes), Back to Main Menu(back) or Quit(no) \n")
                guard let choiceStr: String = readLine() ,!choiceStr.isEmpty else {
                    print("Please select one option!")
                    continue OptionLabel
                }
                choice = choiceStr
                break OptionLabel
            }
            if(choice == "yes"){
                continue SearchMusicLabel
            }else if(choice == "back"){
                break SearchMusicLabel
            }else if(choice == "no"){
                exit(0)
            }
        }
    case "8":
        CreateOrderLabel: while(true){
            CreateOrder()
            var choice: String = "no"
            OptionLabel: while(true){
                print("Continue(yes), Back to Main Menu(back) or Quit(no) \n")
                guard let choiceStr: String = readLine() ,!choiceStr.isEmpty else {
                    print("Please select one option!")
                    continue OptionLabel
                }
                choice = choiceStr
                break OptionLabel
            }
            if(choice == "yes"){
                continue CreateOrderLabel
            }else if(choice == "back"){
                break CreateOrderLabel
            }else if(choice == "no"){
                exit(0)
            }
        }
    case "9":
        DeleteOrderLabel: while(true){
            DeleteOrder()
            var choice: String = "no"
            OptionLabel: while(true){
                print("Continue(yes), Back to Main Menu(back) or Quit(no) \n")
                guard let choiceStr: String = readLine() ,!choiceStr.isEmpty else {
                    print("Please select one option!")
                    continue OptionLabel
                }
                choice = choiceStr
                break OptionLabel
            }
            if(choice == "yes"){
                continue DeleteOrderLabel
            }else if(choice == "back"){
                break DeleteOrderLabel
            }else if(choice == "no"){
                exit(0)
            }
        }
    case "10":
        ViewAllOrders()
        ViewOrdersLabel: while(true){
            print("Back to main menu(yes) or quit(no) \n")
            guard let choiceStr: String = readLine() ,!choiceStr.isEmpty else {
                print("Please select one option!")
                continue ViewOrdersLabel
            }
            if(choiceStr == "yes"){
                break ViewOrdersLabel
            }else{
                exit(0)
            }
        }
    case "0":
        exit(0)
    default:
        print("Please follow the instructions \n")
        continue SystemLabel
    }
}

