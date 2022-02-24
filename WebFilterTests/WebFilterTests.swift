//
//  WebFilterTests.swift
//  WebFilterTests
//
//  Created by Jevgenijs Jefrosinins on 31/01/2022.
//

import XCTest
import WebKit
@testable import WebFilter

class WebFilterTests: XCTestCase {
    
    var mut: WebViewModel!
    var localDataSource: LocalDataSourceProtocol!
    
    override func setUpWithError() throws {
        mut = WebViewModel(localDataSource: MockLocalDataSource())
    }
    
    override func tearDownWithError() throws {
        mut = nil
    }
    
    func test_isForbiddenLink() throws {
        mut.filters = [Filter(rawValue: "facebook")]
        let forbiddenURL = URL(string: "www.facebook.com")
        let forbiddenRequest = URLResponse(url: forbiddenURL!, mimeType: "", expectedContentLength: 0, textEncodingName: "")
        XCTAssertEqual(mut.isForbidden(urlResponse: forbiddenRequest), WKNavigationResponsePolicy.cancel)
        mut.filters.removeAll()
        XCTAssertEqual(mut.isForbidden(urlResponse: forbiddenRequest), WKNavigationResponsePolicy.allow)
    }
    
    func test_isValidFilter() throws {
        let forbiddenFilterWithSpace = Filter(rawValue: " facebook")
        let forbiddenFilterOnlyTwoLetters = Filter(rawValue: "ok")
        XCTAssertEqual(mut.isValidFilter(filter: forbiddenFilterWithSpace), false)
        XCTAssertEqual(mut.isValidFilter(filter: forbiddenFilterOnlyTwoLetters), false)
    }
}
