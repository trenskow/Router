//
//  RouterView.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

@MainActor
public struct RouterView<Root: MountPoint>: View {

	private let baseUrl: URL
	private let initialRelativePath: String

	private let root: Root

	@State private var navigationStack: [URL]

	private var router: Router {
		return Router(
			baseUrl: self.baseUrl,
			root: self.root,
			navigateTo: {
				self.navigationStack
					.append($0)
			},
			navigateBack: {
				_ = self.navigationStack
					.popLast()
			},
			current:  {
				return navigationStack.last
			})
	}

	public init(
		baseUrl: URL,
		initialRelativePath: String = "/",
		root: Root
	) {

		self.baseUrl = baseUrl
		self.initialRelativePath = initialRelativePath
		self.root = root

		guard
			let initialUrl = URL(string: initialRelativePath, relativeTo: baseUrl)
		else {
			fatalError("Initial relative path is invalid")
		}

		self.navigationStack = [initialUrl]

	}

	public var body: some View {

		self.router.currentView()
			.environment(\.openURL, OpenURLAction(
				handler: self.handleURL(_:)))

	}

	private func handleURL(_ url: URL) -> OpenURLAction.Result {

		guard
			self.router.handles(url: url)
		else { return .systemAction }

		self.navigationStack
			.append(url)

		return .handled

	}

}
