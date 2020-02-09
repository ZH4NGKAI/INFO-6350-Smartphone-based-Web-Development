//
//  main.swift
//  Smartphone_Assignment3
//
//  Created by mac on 2/9/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

//swift class
class Flight {
    var airlineName: String
    var seats: Int
    var customers: Int
    init(airlineName: String, seats: Int, customers: Int) {
        self.airlineName = airlineName
        self.seats = seats
        self.customers = customers
    }
    func availableSeats() -> Int {
        return seats - customers
    }
}

class Boeing: Flight {
    
}
let BoeingFlight = Boeing(airlineName: "Boeing", seats:100, customers: 50)
print("The number of available seats is \(BoeingFlight.availableSeats())")
class Airbus: Flight {
    override func availableSeats() -> Int {
        return seats - customers - 2;
    }
}
let AirbusFlight = Airbus(airlineName: "Airbus", seats: 100, customers: 50)
print("The number of available seats is \(AirbusFlight.availableSeats())")

class Airbus101: Airbus {
    
}
let Airbus101Flight = Airbus101(airlineName: "Airbus101", seats: 150, customers: 50)
print("The number of available seats is \(Airbus101Flight.availableSeats())")

//enum
enum Month {
    case Jan
    case Feb
    case Mar
    case Apr
    case May
    case Jun
    case Jul
    case Aug
    case Sep
    case Oct
    case Nov
    case Dec
}
//consider it's 2020, feb has 29days
func NumberOfDays(month:Month){
    switch month {
    case .Jan,.Mar,.May,.Jul,.Aug,.Oct,.Dec:
        print("This month has 31 days")
    case .Apr,.Jun,.Sep,.Nov:
        print("This month has 30 days")
    case .Feb:
        print("This month has 29 days")
    }
}
var month = Month.Feb
NumberOfDays(month: month)

//Structures
struct Cube{
    var length: Int
    var breadth: Int
    var height: Int
    func area() -> Int {
        return (length * breadth + breadth * height + length * height) * 2
    }
}

var cube1 = Cube(length: 3, breadth: 4, height: 5)
var cube2 = cube1
cube2.length = 6
print("Area of cube1 is \(cube1.area())")
print("Area of cube2 is \(cube2.area())")

//Protocols
protocol MastersDegree {
    var GPA: Double { get set }
    var SmartphonesCourseCompleted: Bool { get set }
    
    func printGPA() -> String
    func isSmartphonesCourseCompleted() -> String
}
class Student:MastersDegree{
    var GPA: Double
    var SmartphonesCourseCompleted: Bool
    init(GPA: Double, SmartphonesCourseCompleted: Bool) {
        self.GPA = GPA
        self.SmartphonesCourseCompleted = SmartphonesCourseCompleted
    }
    func printGPA() -> String {
        return "This student's GPA is \(GPA)"
    }
    func isSmartphonesCourseCompleted() -> String {
        if SmartphonesCourseCompleted {
            return "This student has completed Smartphones Course"
        }
        else {
            return "This student has not completed Smartphones Course"
        }
    }
}
let me = Student(GPA: 3.7, SmartphonesCourseCompleted: false)
print(me.printGPA())
print(me.isSmartphonesCourseCompleted())

//Extensions
extension String{
    var stringLength: Int {
        return  self.count
    }
    var concatenateString: String {
        return  self + "Smartphones"
    }
}
let stringExtension:String = "INFO6350"
print(stringExtension.stringLength)
print(stringExtension.concatenateString)


class division {
    var number: Int = 0
}

extension division {
    func dividedBy(number1: Int, number2: Int) {
        print("The divide result is", number1/number2)
    }
}

let div = division()
div.dividedBy(number1: 1800, number2: 3)



