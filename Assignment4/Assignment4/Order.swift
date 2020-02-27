//
//  Order.swift
//  Assignment4
//
//  Created by mac on 2/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
var calendar = Calendar(identifier:Calendar.Identifier.iso8601)

class Order{
    var id: Int = orderId
    var customer: Customer?
    var music: Music?
    var quantity: Int?
    var orderDate: DateComponents?
    var totalPrice: Double?
    static var orderId:Int = 1
    
    init(){}
    init(customer:Customer, music:Music, quantity:Int, orderDate:DateComponents, totalPrice:Double){
        Order.orderId += 1
        self.customer = customer
        self.music = music
        self.quantity = quantity
        self.orderDate = orderDate
        self.totalPrice = totalPrice
    }
    
}

var OrderList : Array<Order> = Array()

func CreateOrder(){
    ViewAllMusics()
    CreateOrderLabel: while(true){
        
        var music: Music? = nil
        var customer:Customer? = nil
        var quantity:Int = 0
        var orderDate:DateComponents = DateComponents(calendar:calendar,year:2019,month:1,day:1)
        
        MusicIdLabel: while(true){
            print("Id of Music you want to buy is : ")
            guard let idStr:String = readLine(), !idStr.isEmpty, Int(idStr) != nil else{
                print("Music id cannot be empty and should be Integer! \n")
                continue
            }
            let music_ = ExistedMusic(id: Int(idStr)!)
            if  music_ == nil {
                print("The music you search doesn't exist! \n")
                continue
            }
            else{
                music = music_!
                break MusicIdLabel
            }
        }
        
        CustomerNameLabel:while(true){
            DisplayAllCustomers()
            print("Id of Customer you want to buy for is : ")
            guard let idStr:String = readLine(), !idStr.isEmpty, Int(idStr) != nil else{
                print("Customer id cannot be empty and should be Integer! \n")
                continue
            }
            let customer_ = ExistedCustomer(id: Int(idStr)!)
            if customer_ == nil{
                print("The customer doesn't exist! \n")
                continue
            }else{
                customer = customer_!
                break CustomerNameLabel
            }
        }
        
        QuantityLabel:while(true){
            print("Quantity of Musics you want to buy is : ")
            guard let quantityStr:String = readLine(), !quantityStr.isEmpty,Int(quantityStr) != nil else{
                print("Quantity cannot be empty! \n")
                continue
            }
            guard Int(quantityStr)! <= music!.quantity else{
                print("Sorry! The remaining quantity of this music is only \(music!.quantity) \n")
                continue
            }
            quantity = Int(quantityStr)!
            music!.quantity -= quantity
            break QuantityLabel
        }
        
        DateLabel: while(true){
            var day = ""
            OrderDateLabel:while(true){
                
                print("Month of order is : ")
                guard let monthStr:String = readLine(), !monthStr.isEmpty else{
                    print("Order Month cannot be empty! \n")
                    continue
                }
                while(true){
                    print("Day of order is : ")
                    guard let dayStr:String = readLine(), !dayStr.isEmpty else{
                        print("Order Day cannot be empty! \n")
                        continue
                    }
                    day = dayStr
                    break
                }
                orderDate = DateComponents(calendar: calendar, year: 2020, month: Int(monthStr)!, day:Int(day)!)
                if(!orderDate.isValidDate){
                    print("Not valid date, please check the input")
                    continue
                }
                break OrderDateLabel
            }
            break DateLabel
        }
        
        let order = Order()
        order.music = music!
        order.customer = customer!
        order.quantity = quantity
        order.orderDate = orderDate
        order.totalPrice = music!.price * Double(quantity)
        OrderList.append(order)
        print("Order of \(quantity) \(music!.name) for \(customer!.name) is created successfully! \n")
        break CreateOrderLabel
    }
    
}

func ViewAllOrders(){
    if OrderList.isEmpty {
        print("No order in system now! \n")
        
    }
    else{
        print("----------------- All Orders are here ------------------ ")
        for Order in OrderList {
            print("Id: \(Order.id), Music: \(Order.music!.name), Customer: \(Order.customer!.name), Quantity: \(Order.quantity!), Order Date: \(Order.orderDate!.year!)-\(Order.orderDate!.month!)-\(Order.orderDate!.day!), Total Price: \(Order.totalPrice!) \n")
        }
    }
}

func ExistedOrder(id:Int) -> Order?{
    for Order in OrderList{
        if(Order.id==id){
            return Order
        }
    }
    return nil
}


func DeleteOrder(){
    ViewAllOrders()
    while (true) {
        print("Please input the id of the order who you want to delete \n")
        guard let id:String = readLine(), !id.isEmpty, Int(id) != nil else{
            print("Id cannot be empty! \n")
            continue
        }
        if (ExistedOrder(id: Int(id)!) == nil){
            print("Order doesn't exist \n")
            continue
        }else{
            for i in 0...OrderList.count-1{
                if(OrderList[i].id == Int(id)!){
                    print(OrderList[i].id)
                    OrderList[i].music?.quantity += OrderList[i].quantity!
                    OrderList.remove(at:i)
                    print("Order No. \(id) is deleted successfully! \n")
                    ViewAllOrders()
                    break
                }
            }
        }
        break
    }
}

