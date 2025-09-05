//
//  ItemType.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

extension QueryCoder {

	indirect enum ItemType {
		case constant(String)
		case container([String: ItemType])
	}

}

extension Dictionary where Key == String, Value == QueryCoder.ItemType {

	static func from(
		dictionary: [String: String]
	) -> Self {

		var result = Self()

		var containers: [String: [String: String]] = [:]

		for (key, value) in dictionary {

			let keyPaths = key.split(separator: ".")
				.map { String($0) }

			if keyPaths.count <= 1 {
				result[key] = .constant(value)
			} else {
				containers[keyPaths[safe: 0] ?? "", default: [:]][keyPaths.dropFirst().joined(separator: ".")] = value
			}

		}

		for (key, value) in containers {
			result[key] = .container(Self.from(dictionary: value))
		}

		return result

	}

	func toDictionary() -> [String: String] {

		var result: [String: String] = [:]

		for (key, value) in self {
			switch value {
			case .constant(let value):
				result[key] = value
			case .container(let container):
				let subDictionary = container.toDictionary()
				for (subKey, subValue) in subDictionary {
					result["\(key).\(subKey)"] = subValue
				}
			}
		}

		return result

	}


}
