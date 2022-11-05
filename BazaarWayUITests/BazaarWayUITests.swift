//
//  BazaarWayUITests.swift
//  BazaarWayUITests
//
//  Created by Asım can Yağız on 5.11.2022.
//

import XCTest

final class BazaarWayUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    
    func testApplicationFlow() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let nextStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Next"]/*[[".buttons[\"Next\"].staticTexts[\"Next\"]",".staticTexts[\"Next\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(nextStaticText.waitForExistence(timeout: 2))
        nextStaticText.tap()
        nextStaticText.tap()
        let finishLine = app/*@START_MENU_TOKEN@*/.staticTexts["Finish"]/*[[".buttons[\"Finish\"].staticTexts[\"Finish\"]",".staticTexts[\"Finish\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(finishLine.exists)
        finishLine.tap()
        
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssertTrue(tabBar.exists)
        let tabbarSearch = tabBar.buttons["Search"]
        XCTAssertTrue(tabbarSearch.exists)
        tabbarSearch.tap()
        let tabbarProfile = tabBar.buttons["Profile"]
        tabbarProfile.tap()
        
    }
    
    
    
    func testBasketest() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let skipStaticText = app.staticTexts["Skip"]
        XCTAssertTrue(skipStaticText.waitForExistence(timeout: 2))
        skipStaticText.tap()
        
        let FirstProduct = app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 8 pages")/*[[".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 8 pages\")",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 8 pages\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(FirstProduct.exists)
        FirstProduct.tap()
        
        let productButtonStepper = app.steppers.buttons["Increment"]
        XCTAssertTrue(productButtonStepper.exists)
        productButtonStepper.tap()
        
        let addCartButton = app/*@START_MENU_TOKEN@*/.staticTexts["Add to Cart"]/*[[".buttons[\"Add to Cart\"].staticTexts[\"Add to Cart\"]",".staticTexts[\"Add to Cart\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(addCartButton.exists)
        addCartButton.tap()
        
        let showAlertTest = app.alerts["Succes"].scrollViews.otherElements.buttons["OK"]
        XCTAssertTrue(showAlertTest.exists)
        showAlertTest.tap()
        
        let closeProductButton = app/*@START_MENU_TOKEN@*/.staticTexts["X"]/*[[".buttons[\"X\"].staticTexts[\"X\"]",".staticTexts[\"X\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(closeProductButton.exists)
        closeProductButton.tap()
        
        let basketItem = app.navigationBars["UITabBar"].buttons["shopping cart"]
        XCTAssertTrue(basketItem.exists)
        basketItem.tap()
        
        let basketItemStepper = app.collectionViews/*@START_MENU_TOKEN@*/.steppers/*[[".cells.steppers",".steppers"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Decrement"]
        XCTAssertTrue(basketItemStepper.waitForExistence(timeout: 2))
        basketItemStepper.tap()
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    
    
    func testLogin() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let skipStaticText = app.staticTexts["Skip"]
        XCTAssertTrue(skipStaticText.waitForExistence(timeout: 2))
        skipStaticText.tap()
        
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssertTrue(tabBar.exists)
        let tabbarProfile = tabBar.buttons["Profile"]
        XCTAssertTrue(tabbarProfile.exists)
        tabbarProfile.tap()
        
        
        let loginText = app.staticTexts["Log In"]
        XCTAssertTrue(loginText.exists)
        loginText.tap()
        
        let emailTextField = app.textFields["E-Mail"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("test@test.com")
        
        let passwordTextField = app.textFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        
        let authButton = app.buttons["Button"]
        XCTAssertTrue(authButton.exists)
        authButton.tap()
                
        
    }
    
    func testSearchArea() throws {
        let app = XCUIApplication()
        app.launch()
        
        
        let skipStaticText = app.staticTexts["Skip"]
        XCTAssertTrue(skipStaticText.waitForExistence(timeout: 2))
        skipStaticText.tap()
        
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssertTrue(tabBar.exists)
        let tabbarSearch = tabBar.buttons["Search"]
        XCTAssertTrue(tabbarSearch.exists)
        tabbarSearch.tap()
        
        let element = app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(element.exists)
        element.tap()
        
        let xButton = app.buttons["X"]
        XCTAssertTrue(xButton.exists)
        xButton.tap()
        
        let segmentedWomen = app/*@START_MENU_TOKEN@*/.buttons["Women's"]/*[[".segmentedControls.buttons[\"Women's\"]",".buttons[\"Women's\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(segmentedWomen.waitForExistence(timeout: 2))
        segmentedWomen.tap()
        XCTAssertTrue(element.exists)
        element.tap()
        let xStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["X"]/*[[".buttons[\"X\"].staticTexts[\"X\"]",".staticTexts[\"X\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(xStaticText.exists)
        xStaticText.tap()
        
        let segmentedMen = app/*@START_MENU_TOKEN@*/.buttons["Men's"]/*[[".segmentedControls.buttons[\"Men's\"]",".buttons[\"Men's\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(segmentedMen.waitForExistence(timeout: 2))
        segmentedMen.tap()
        XCTAssertTrue(element.exists)
        element.tap()
        XCTAssertTrue(xStaticText.exists)
        xStaticText.tap()
        
        let segmentedJewelery = app/*@START_MENU_TOKEN@*/.buttons["Jewelery"]/*[[".segmentedControls.buttons[\"Jewelery\"]",".buttons[\"Jewelery\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(segmentedJewelery.waitForExistence(timeout: 2)exists)
        segmentedJewelery.tap()
        XCTAssertTrue(element.exists)
        element.tap()
        XCTAssertTrue(xStaticText.exists)
        xStaticText.tap()
        
        let segmentedElectronics = app/*@START_MENU_TOKEN@*/.buttons["Electronics"]/*[[".segmentedControls.buttons[\"Electronics\"]",".buttons[\"Electronics\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(segmentedElectronics.waitForExistence(timeout: 2))
        segmentedElectronics.tap()
        XCTAssertTrue(element.exists)
        element.tap()
        XCTAssertTrue(xStaticText.exists)
        xStaticText.tap()
        
        let segmentedAll = app/*@START_MENU_TOKEN@*/.buttons["All"]/*[[".segmentedControls.buttons[\"All\"]",".buttons[\"All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(segmentedAll.waitForExistence(timeout: 2))
        segmentedAll.tap()
        XCTAssertTrue(element.exists)
        element.tap()
        XCTAssertTrue(xStaticText.exists)
        xStaticText.tap()
                
    }
    
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    
}
