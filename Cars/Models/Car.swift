//
//  Car.swift
//  Cars
//
//  Created by Tatia on 3/24/21.
//

import UIKit

struct Car {
    let name: String
    let price: Int = Int.random(in: 10000...40000)
    var amount: Int = 0
    
    var image: UIImage? {
        return UIImage(named: name)
    }
}

struct CarManufacturer {
    let name: String
    var cars: [Car]
    
    var image: UIImage? {
        return UIImage(named: name)
    }
    
    var totalAmount: Int {
        
        var totalAmount = 0
        for car in cars {
            totalAmount += car.amount
        }
        return totalAmount
        
    }
    
    var totalPrice: Int {
        var totalPrice = 0
        for car in cars {
            totalPrice += car.price * car.amount
        }
        return totalPrice
    }
    
}

struct CarSection {
    let title: String
    var manufacturers: [CarManufacturer]
    
    var totalAmount: Int {
        var totalAmount = 0
        for car in manufacturers {
            totalAmount += car.totalAmount
        }
        return totalAmount
    }
    
    var totalPrice: Int {
        var totalPrice = 0
        for car in manufacturers {
            totalPrice += car.totalPrice
        }
        return totalPrice
    }
}
