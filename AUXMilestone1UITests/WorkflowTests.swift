import XCTest

final class WorkflowTests: XCTestCase {
    func capture(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testMainWorkflow() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["myRankings"].waitForExistence(timeout: 10))
        capture("01-Home")
        app.buttons["myRankings"].tap()
        let table = app.tables["rankingsTable"]
        XCTAssertTrue(table.waitForExistence(timeout: 5))
        XCTAssertEqual(table.cells.count, 6)
        capture("02-My-Rankings")
        table.cells.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["editSong"].waitForExistence(timeout: 5))
        capture("03-Song-Detail")
        app.buttons["editSong"].tap()
        let title = app.textFields["songTitle"]
        XCTAssertTrue(title.waitForExistence(timeout: 5))
        capture("04-Edit-Song")
        title.tap()
        title.typeText(" (favorite)")
        app.toolbars.buttons["Done"].tap()
        if !app.buttons["saveSong"].isHittable { app.swipeUp() }
        app.buttons["saveSong"].tap()
        XCTAssertTrue(app.staticTexts["Ivy (favorite)"].waitForExistence(timeout: 5))
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(table.waitForExistence(timeout: 5))
        XCTAssertTrue(table.cells.element(boundBy: 0).staticTexts["1.  Ivy (favorite)"].exists)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.buttons["addSong"].tap()
        XCTAssertTrue(title.waitForExistence(timeout: 5))
        capture("05-Add-Song")
        if !app.buttons["saveSong"].isHittable { app.swipeUp() }
        app.buttons["saveSong"].tap()
        XCTAssertTrue(app.alerts["Add song details"].waitForExistence(timeout: 5))
        app.alerts.buttons["OK"].tap()
        app.swipeDown()
        title.tap()
        title.typeText("Test Listen")
        app.textFields["songArtist"].tap()
        app.textFields["songArtist"].typeText("Demo Artist")
        app.toolbars.buttons["Done"].tap()
        if !app.buttons["saveSong"].isHittable { app.swipeUp() }
        app.buttons["saveSong"].tap()
        XCTAssertTrue(app.staticTexts["7 songs in your collection"].waitForExistence(timeout: 5))
        app.buttons["myRankings"].tap()
        XCTAssertEqual(table.cells.count, 7)
    }
}
