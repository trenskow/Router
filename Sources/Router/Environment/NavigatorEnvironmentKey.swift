//
//  NavigatorEnvironmentKey.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

public struct NavigatorEnvironmentKey: EnvironmentKey {
	public static let defaultValue: Navigator? = nil
}

extension EnvironmentValues {
	public var navigator: Navigator? {
		get { self[NavigatorEnvironmentKey.self] }
		set { self[NavigatorEnvironmentKey.self] = newValue }
	}
}
