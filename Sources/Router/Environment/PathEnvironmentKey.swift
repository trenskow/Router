//
//  PathEnvironmentKey.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

public struct PathEnvironmentKey: EnvironmentKey {
	public static let defaultValue: [String]? = nil
}

extension EnvironmentValues {
	public var path: [String]? {
		get { self[PathEnvironmentKey.self] }
		set { self[PathEnvironmentKey.self] = newValue }
	}
}
