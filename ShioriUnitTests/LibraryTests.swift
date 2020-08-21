//
//  LibraryTests.swift
//  ShioriUnitTests
//
//  Created by hikinit on 21/08/20.
//

import XCTest

class LibraryTests: XCTestCase {
  var library: Library!
  var coreDataStack: CoreDataStack!

  override func setUp() {
    super.setUp()

    coreDataStack = CoreDataStack()
    library = Library(coreDataStack: coreDataStack)
  }

  func testAddSeries() {
    let websiteUrlString = "https://example.com"
    let websiteUrl = URL(string: websiteUrlString)

    let series = library.addSeries(
      title: "Overgeared",
      kind: .webnovel,
      status: .onhold,
      website: websiteUrlString
    )

    XCTAssertEqual(series.title, "Overgeared")
    XCTAssertEqual(series.kind, "Web Novel")
    XCTAssertEqual(series.status, "onhold")
    XCTAssertNotNil(series.id, "Id should not be nil")
    XCTAssertEqual(series.website, websiteUrl)
  }
}
