//
//  Router.swift
//  Router
//
//  Created by Kristian Trenskow on 09/03/2025.
//

import SwiftUI

@MainActor
public struct Router<Content: View>: View {

	@State private var stack: [String] = []

	private let baseURL: URL
	private let content: () -> Content

	public init(
		baseURL: URL,
		@ViewBuilder content: @escaping () -> Content
	) {
		self.baseURL = baseURL
		self.content = content
	}

	public var body: some View {
		self.content()
			.environment(\.url, self.url)
			.environment(\.routerRemainingPathComponents, self.pathComponents)
			.environment(\.query, self.query)
			.environment(\.navigator, self)
			.onOpenURL { url in

				guard
					self.baseURL.host == url.host,
					self.baseURL.scheme == url.scheme
				else { return }

				self.stack.append(
					url.path())

			}
	}

	private var url: URL {
		return self.stack
			.reduce(self.baseURL) {
				URL(string: $1, relativeTo: $0)!
			}
	}

	private var pathComponents: [String] {
		return URLComponents(
			url: self.url,
			resolvingAgainstBaseURL: true
		)!
		.path
		.components(separatedBy: "/")
		.filter { $0 != "" }
		.map { $0.removingPercentEncoding! }
	}

	private var query: [String: String] {
		return (URLComponents(
			url: self.url,
			resolvingAgainstBaseURL: true
		)!
		.queryItems?
		.reduce(into: [:], { partialResult, queryItem in
			partialResult[queryItem.name] = queryItem.value
		})) ?? [:]
	}

}

extension Router: RouterNavigator {

	public func navigate(to relativePath: String) {
		self.stack.append(
			relativePath)
	}

	public func back() {
		self.stack.removeLast()
	}

}

public struct URLKey: EnvironmentKey {
	public static let defaultValue: URL? = nil
}

struct RouterRemainingPathComponentsKey: EnvironmentKey {
	static let defaultValue: [String] = []
}

public struct QueryKey: EnvironmentKey {
	public static let defaultValue: [String: String] = [:]
}

@MainActor
public struct NavigatorKey: @preconcurrency EnvironmentKey {
	public static let defaultValue: RouterNavigator? = nil
}

extension EnvironmentValues {

	public var url: URL? {
		get { self[URLKey.self] }
		set { self[URLKey.self] = newValue }
	}

	var routerRemainingPathComponents: [String] {
		get { self[RouterRemainingPathComponentsKey.self] }
		set { self[RouterRemainingPathComponentsKey.self] = newValue }
	}

	public var query: [String: String] {
		get { self[QueryKey.self] }
		set { self[QueryKey.self] = newValue }
	}

	public var navigator: RouterNavigator? {
		get { self[NavigatorKey.self] }
		set { self[NavigatorKey.self] = newValue }
	}

}
