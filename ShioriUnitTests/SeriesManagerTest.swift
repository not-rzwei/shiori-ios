//
//  LibraryTests.swift
//  ShioriUnitTests
//
//  Created by hikinit on 21/08/20.
//

import XCTest

class SeriesManagerTest: XCTestCase {
  var manager: EntityManager<Series>!
  var coreDataStack: CoreDataStack!

  override func setUp() {
    coreDataStack = TestCoreDataStack()
    manager = EntityManager(
      coreDataStack: coreDataStack,
      context: coreDataStack.context
    )
  }

  override func tearDown() {
    coreDataStack = nil
    manager = nil
  }

  func stubMaker(context: NSManagedObjectContext) ->  Series {
    return Series(context: context,
                  title: "Overgeared",
                  kind: .webnovel,
                  status: .onhold,
                  website: "https://example.com")
  }

  func testGetAllSeries() {
    var allSeries = manager.getAll()
    XCTAssertEqual(allSeries.count, 0)

    let newSeries = manager.add(stubMaker)

    allSeries = manager.getAll()

    XCTAssertEqual(allSeries.count, 1)
    XCTAssertEqual(allSeries.first, newSeries)
  }

  func testAddSeries() {
    let websiteUrlString = "https://example.com"
    let websiteUrl = URL(string: websiteUrlString)

    let newSeries = manager.add(stubMaker)

    XCTAssertEqual(newSeries.title, "Overgeared")
    XCTAssertEqual(newSeries.kind, "Web Novel")
    XCTAssertEqual(newSeries.status, "onhold")
    XCTAssertNotNil(newSeries.id, "Id should not be nil")
    XCTAssertEqual(newSeries.website, websiteUrl)

    let fetchedSeries = manager.getAll()
    XCTAssertEqual(fetchedSeries.first, newSeries)
  }

  func testDeleteSeries() {
    let newSeries = manager.add(stubMaker)
    var allSeries = manager.getAll()
    XCTAssertEqual(allSeries.count, 1)

    manager.delete(newSeries)
    allSeries = manager.getAll()
    XCTAssertEqual(allSeries.count, 0)
  }

  func testUpdateSeries() {
    let newSeries = manager.add(stubMaker)

    newSeries.title = "Overgearedd"

    XCTAssertTrue(coreDataStack.context.hasChanges)

    manager.update(newSeries)

    XCTAssertFalse(coreDataStack.context.hasChanges)
  }
}
