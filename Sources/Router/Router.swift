//
//  Router.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import Foundation
import SwiftUI

@MainActor
public struct Router: Sendable {

	public let baseUrl: URLComponents
	public let root: MountPoint

	public let navigateTo: @MainActor @Sendable (URL) -> Void
	public let navigateBack: @MainActor @Sendable () -> Void
	public let current: @MainActor @Sendable () -> URL?

	public init(
		baseUrl: URL,
		root: MountPoint,
		navigateTo: @escaping @MainActor @Sendable (URL) -> Void,
		navigateBack: @escaping @MainActor @Sendable () -> Void,
		current: @escaping @MainActor @Sendable () -> URL?
	) {

		guard
			let baseUrl = baseUrl.components
		else {
			fatalError("Base URL is invalid")
		}

		self.baseUrl = baseUrl
		self.root = root
		self.navigateTo = navigateTo
		self.navigateBack = navigateBack
		self.current = current

	}

	public func handles(
		url: URL
	) -> Bool {

		guard
			let urlComponents = url.components,
			let path = self.path(
				urlComponents: urlComponents)
		else {
			return false
		}

		return self.root.handles(
			pathComponents: path,
			queryItems: urlComponents.queryItems ?? [])

	}

	public func view(
		for url: URL
	) throws -> some View {

		guard
			let urlComponents = url.components,
			let path = self.path(
				urlComponents: urlComponents)
		else {
			throw RouterError.invalidUrl
		}

		return try self.root.view(
			for: path,
			in: urlComponents)
			.environment(\.urlComponents, urlComponents)
			.environment(\.path, path)
			.environment(\.navigator, Navigator(
				baseUrl: self.baseUrl.url!,
				navigateTo: self.navigateTo,
				navigateBack: self.navigateBack,
				current: self.current))

	}

	@ViewBuilder
	public func currentView() -> some View {

		if
			let url = self.current(),
			let view = try? self.view(for: url) {
			view
		} else {
			EmptyView()
		}

	}

}

extension Router {

	func path(
		urlComponents: URLComponents
	) -> [String]? {

		guard
			urlComponents.scheme == baseUrl.scheme,
			urlComponents.host == baseUrl.host,
			urlComponents.port == baseUrl.port
		else {
			return nil
		}

		guard
			let pathComponents = try? self.basePath(
				urlPathComponents: urlComponents.pathComponents)
		else {
			return nil
		}

		guard
			self.root.handles(
				pathComponents: pathComponents,
				queryItems: urlComponents.queryItems ?? [])
		else { return nil }

		return pathComponents

	}

	func basePath(
		urlPathComponents: [String]
	) throws -> [String] {

		let basePathComponents = self.baseUrl.pathComponents

		guard
			urlPathComponents.count >= basePathComponents.count
		else {
			throw RouterError.invalidUrl
		}

		for (index, component) in basePathComponents.enumerated() {
			guard
				urlPathComponents[index] == component
			else {
				throw RouterError.invalidUrl
			}
		}

		return Array(
			urlPathComponents
				.dropFirst(basePathComponents.count))

	}

}
