//
//  RouterApp.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

public protocol RouterApp : App {

	associatedtype Root: MountPoint

	static var baseURL: URL { get }
	static var initialRelativePath: String { get }

	var current: URL? { get }

	@MainActor
	var root: Root { get }

	func navigate(
		to url: URL
	)

	func navigateBack()

}

extension RouterApp {

	public var initialRelativePath: String {
		return "/"
	}

	var router: Router {
		return Router(
			baseUrl: Self.baseURL,
			root: self.root,
			navigateTo: { @MainActor url in
				self.navigate(
					to: url)
			},
			navigateBack: { @MainActor in
				self.navigateBack()
			},
			current: {
				return self.current
			})
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
