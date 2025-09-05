//
//  RouterApp.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

public protocol RouterApp : App {

	static var baseURL: URL { get }
	static var initialRelativePath: String { get }

	var router: Router { get }

	func navigate(
		to url: URL
	)

}

extension RouterApp {

	public var initialRelativePath: String {
		return "/"
	}

	public var body: some Scene {
		WindowGroup {
			self.router.currentView()
				.environment(\.openURL, OpenURLAction(
					handler: self.handleURL(_:)))
				.task {
					self.navigate(
						to: URL(string: Self.initialRelativePath, relativeTo: Self.baseURL)!)
				}
		}
	}

	public func handleURL(_ url: URL) -> OpenURLAction.Result {

		guard
			self.router.handles(url: url)
		else { return .systemAction }

		self.navigate(
			to: url)

		return .handled

	}

}
