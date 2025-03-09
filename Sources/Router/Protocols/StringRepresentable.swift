//
// StringRepresentable.swift
// Router-games-frontend-app-ios
//
// Created by Kristian Trenskow on 2023/07/08
// See license in LICENSE.
//

import Foundation

public protocol StringRepresentable {
	init?(stringValue: String)
}

extension Bool: StringRepresentable {
	public init?(stringValue: String) {
		guard ["true", "false"].contains(stringValue)
			else { return nil }
		self = stringValue == "true"
	}
}

extension String: StringRepresentable {
	public init?(stringValue: String) {
		self = stringValue
	}
}

extension Double: StringRepresentable {
	public init?(stringValue: String) {
		guard let value = Double(stringValue)
			else { return nil }
		self = value
	}
}

extension Float: StringRepresentable {
	public init?(stringValue: String) {
		guard let value = Float(stringValue)
			else { return nil }
		self = value
	}
}

extension Int: StringRepresentable {
	public init?(stringValue: String) {
		guard let value = Int(stringValue)
			else { return nil }
		self = value
	}
}

extension Int8: StringRepresentable {
	public init?(stringValue: String) {
		guard let value = Int8(stringValue)
			else { return nil }
		self = value
	}
}

extension Int16: StringRepresentable {
	public init?(stringValue: String) {
		guard let value = Int16(stringValue)
			else { return nil }
		self = value
	}
}

extension Int32: StringRepresentable {
	public init?(stringValue: String) {
		guard let value = Int32(stringValue)
			else { return nil }
		self = value
	}
}

extension Int64: StringRepresentable {
	public init?(stringValue: String) {
		guard let value = Int64(stringValue)
			else { return nil }
		self = value
	}
}

extension UInt: StringRepresentable {
	public init?(stringValue: String) {
		guard let value = UInt(stringValue)
			else { return nil }
		self = value
	}
}

extension UInt8: StringRepresentable {
	public init?(stringValue: String) {
		guard let value = UInt8(stringValue)
			else { return nil }
		self = value
	}
}

extension UInt16: StringRepresentable {
	public init?(stringValue: String) {
		guard let value = UInt16(stringValue)
			else { return nil }
		self = value
	}
}

extension UInt32: StringRepresentable {
	public init?(stringValue: String) {
		guard let value = UInt32(stringValue)
			else { return nil }
		self = value
	}
}

extension UInt64: StringRepresentable {
	public init?(stringValue: String) {
		guard let value = UInt64(stringValue)
			else { return nil }
		self = value
	}
}

extension URL: StringRepresentable {
	public init?(stringValue: String) {
		guard let url = URL(string: stringValue)
		else { return nil }
		self = url
	}
}
