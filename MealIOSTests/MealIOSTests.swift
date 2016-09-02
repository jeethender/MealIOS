//
//  MealIOSTests.swift
//  MealIOSTests
//
//  Created by maisapride8 on 08/06/16.
//  Copyright © 2016 maisapride8. All rights reserved.
//

import XCTest
@testable import MealIOS

class MealIOSTests: XCTestCase {
    
func testMealInitialization()
{
 
    // Success case
     let potentialItem = Meal(name: "Newest Meal", photo: nil, rating: 2)
    XCTAssertNotNil(potentialItem)
    
    //Failute Case
    let noName = Meal(name: "", photo: nil, rating: 0)
    XCTAssertNil(noName,"Empty Name is Invalid")
    
    // BadRating
    let badRating = Meal(name: "Bating Rating given", photo: nil, rating: -1)
    XCTAssertNil(badRating,"Negative ratings are Invalid, please provide Positive rating")
    
 }
    
}
