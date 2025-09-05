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

	@MainActor
	var root: Root { get }

}

extension RouterApp {

	public var initialRelativePath: String {
		return "/"
	}

	public var body: some Scene {
		WindowGroup {
			RouterView(
				baseUrl: Self.baseURL,
				initialRelativePath: Self.initialRelativePath,
				root: self.root)
		}
	}

}
