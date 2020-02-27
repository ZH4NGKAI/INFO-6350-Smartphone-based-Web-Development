//
//  Customer.swift
//  Assignment4
//
//  Created by mac on 2/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
class Customer{
    var id: Int = customerId
    var name: String = ""
    var email: String = ""
    static var customerId:Int = 1
    
    init(){}
    init(name:String, email:String){
        Customer.customerId += 1
        self.name = name
        self.email = email
    }
}

var CustomerList: Array<Customer> = Array()

func AddCustomer() {
    while true{
        var name:String = ""
        var email:String = ""
        while true{
            print("Name:")
            guard let nameStr:String = readLine(), !nameStr.isEmpty else{
                print("Name cannot be empty! \n")
                continue
            }
            name = nameStr
            break
        }
            
        while true{
            print("Email:")
            guard let emailStr:String = readLine(), !emailStr.isEmpty else{
                print("Email cannot be empty! \n")
                continue
            }
            guard validateEmail(emailStr: emailStr) else{
                print("Please input the email in the correct format \n")
                continue
            }
            email = emailStr
            break
        }
        let customer = Customer(name: name, email: email)
        CustomerList.append(customer)
        print("Customer: \(customer.id) created successfully! \n")
//        DisplayAllCustomers()
        break
    }
}

func validateEmail(emailStr: String) -> Bool {
    let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailTest.evaluate(with: emailStr)
}

func ExistedCustomer(id: Int) -> Customer?{
    for Customer in CustomerList{
        if Customer.id == id{
            return Customer
        }
    }
    return nil
}

func DeleteCustomer(){
    DisplayAllCustomers()
    while (true) {
        print("Please input the id of the customer to be delete \n")
        guard let idStr:String = readLine(), !idStr.isEmpty, Int(idStr) != nil else{
            print("id cannot be empty and should be Integer! \n")
            continue
        }
        let id = Int(idStr)
        if ExistedCustomer(id: id!) == nil{
            print("Customer doesn't exist \n")
            continue
        }
        for i in 0...CustomerList.count-1{
            if(CustomerList[i].id == id){
                CustomerList.remove(at:i)
                print("\(idStr)Customer is deleted\n")
//                DisplayAllCustomers()
                break
            }
        }
        break
    }
}

func DisplayAllCustomers(){
    if CustomerList.isEmpty {
        print("No Customer now \n")
    }
    else{
        print("------------------ All Customers are here ---------------------")
        for Customer in CustomerList{
            print("Id: \(Customer.id), Name: \(Customer.name), Email: \(Customer.email)\n")
        }
        print("----------------------------------------------------------------")
    }
}


 
