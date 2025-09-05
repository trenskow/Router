//
//  Navigator.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

@MainActor
public struct Navigator: Sendable {

	private let baseUrl: URL
	private let navigateTo: @MainActor @Sendable (URL) -> Void
	private let navigateBack: @MainActor @Sendable () -> Void
	private let current: @MainActor @Sendable () -> URL?

	init(
		baseUrl: URL,
		navigateTo: @escaping @MainActor @Sendable (URL) -> Void,
		navigateBack: @escaping @MainActor @Sendable () -> Void,
		current: @escaping @MainActor @Sendable () -> URL?
	) {
		self.baseUrl = baseUrl
		self.navigateTo = navigateTo
		self.navigateBack = navigateBack
		self.current = current
	}

	public func navigate(
		to relativePath: String
	) throws {

		guard
			let url = URL(string: relativePath,
						  relativeTo: self.current() ?? self.baseUrl)
		else {
			throw RouterError.invalidUrl
		}

		self.navigateTo(url)
	}

	public func navigate<Data: Encodable>(
		to relativePath: String,
		with data: Data
	) throws {

		let queryItems = try QueryCoder.TopLevelEncoder().encode(data)
			.toDictionary()
			.toQueryItems()

		guard
			let url = URL(
				string: relativePath,
				relativeTo: self.current() ?? self.baseUrl),
			var components = url.components
		else {
			throw RouterError.invalidUrl
		}

		components.queryItems = (components.queryItems ?? []) + queryItems

		guard
			let url = components.url
		else {
			throw RouterError.invalidUrl
		}

		self.navigateTo(url)

	}

	public func back() {
		self.navigateBack()
	}

}
