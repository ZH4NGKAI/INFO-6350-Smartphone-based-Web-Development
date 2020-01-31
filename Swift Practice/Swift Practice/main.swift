//
//  main.swift
//  Swift Practice
//
//  Created by mac on 1/28/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

print("Hello, World!")
//Swift Variabel
let x = 5
let y = 4
var area = y*x*x
print(area)

var university : String = "Northeastern"
var course = "Smartphone"
university.append(course)
print(university)

var exvalue: Int = 12
var imvalue = 12
print(exvalue*exvalue)
print(imvalue*imvalue)

var 🐭 = "iPhone"
var 🐮 = "iPhone\u{301}"

var compare = 🐭==🐮
print(compare)

//Swift Arrays
var city = [String]()
city = ["Los Angles", "Seattle", "Palo Alto"]
city.append(contentsOf: ["Boston", "New York"])
city.insert("San Francisco", at: 2)
city.remove(at: 3)
print(city.count)
print(city)

//Swift Loops
var nums = [Int]()
var sum = 0
for i in 1...100 {
    if i%2 == 0 {
        nums.append(i)
    }
}
for i in nums {
    sum += i;
    print(i)
}
print(sum)
var index = 0
repeat {
    nums[index] += 3
    index += 1
} while index < nums.count

let student: String = "Kai Zhang"
let studentArray: [Character] = Array(student)
for (index, item) in studentArray.enumerated(){
    print("The \(index)st character is \(item)")
}


//Swift Function
func add(x: Double, y: Double) -> Double {
    return x+y
}

//absolute difference
func subtract(x: Int, y: Int) -> Int {
    if x>y {
        return x-y
    }
    else{
        return y-x
    }
}

func multiply(x: Float, y: Float) -> Float {
    return x * y
}

assert(add(x:3.4, y:4.6) == 8, "add test failed!")
assert(subtract(x: 7, y: -7) == 14, "substract test failed!")
assert(multiply(x: 2.5, y: 4.8) == 12, "multiply test failed!")

func test(x: Int) -> (Int, Int, Int) {
    var temp = x
    var addResult: Int = 0
    var subResult: Int = 0
    var multResult: Int = 1
    repeat {
        addResult = temp%10 + addResult
        subResult = temp%10 - subResult
        multResult = (temp%10) * multResult
        temp = temp/10
    } while temp != 0
    return (addResult, subResult, multResult)
}
print(test(x: 6350))


//Conditions
func fridge(milkAge: Int, eggsAge: Int) {
    if milkAge <= 21 && eggsAge <= 10 {
        print("you can still use your milk and eggs")
    }
    else {
        if milkAge > 21 {
            print("you should throw away the milk");
        }
        if eggsAge > 10 {
            print("you should throw away the egg");
        }
    }
}

fridge(milkAge: 22, eggsAge: 11)

func twoSame(first: Int, second: Int, third: Int) {
    let compare: Bool = (first == second) || (first == third) || (second == third)
    switch compare {
        case false:
            print("the values are different")
        case true:
            print("two values are at least identical")
    }
}

twoSame(first: 2, second: 3, third: 4)

//Swift Dictionary and Tuples
var nameDicts = [["firstName": "Kawhi", "lastName": "Leonard"],
                 ["firstName": "Kobe", "lastName": "Bryant"],
                 ["firstName": "Lebron", "lastName": "James"],
                 ["firstName": "Michael", "lastName": "Jordan"]]

var firstNameArray: [String] = []
for nameDict in nameDicts {
    firstNameArray.append(nameDict["firstName"]!)
}
print(firstNameArray)

var nameArray: [String] = []
for nameDict in nameDicts {
    let name = nameDict["firstName"]! + "." + nameDict["lastName"]!
    nameArray.append(name)
}
print(nameArray)

typealias MyTupleType = (String, String)
let MyTuple: MyTupleType = ("001306003", "Kai Zhang")
print(MyTuple.0)
print(MyTuple.1)


//Swift Optional
let optvar : Int? = nil
let unwrapme : String? = nil
if let unwrappedValue: String = unwrapme {
    print(unwrappedValue)
}
else {
    print("nil")
}

var zero: Optional<Int>
zero = Optional(0)

var value1 : Int?
var defaultValue : Int = 7
if value1 != nil {
    print(value1!)
}
else {
    print(defaultValue)
}
print(value1 ?? defaultValue)


func sendToServer(name: String, address: String) {
    print("Send to the server")
}
func send(txtname:String?,txtaddress:String?) {
    guard let name = txtname else {
        print("No name provided")
        return
    }
    guard let address = txtaddress else {
        print("No address provided")
        return
    }
    sendToServer(name: name, address: address)
}
send(txtname: "Kai Zhang", txtaddress: "111 St")
