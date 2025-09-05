//
//  TopLevelDecoder.Decoder.UnkeyedContainer.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

extension QueryCoder.TopLevelDecoder.Decoder {

	struct UnkeyedContainer: UnkeyedDecodingContainer, ValueDecoder {

		let codingPath: [any CodingKey]
		let userInfo: [CodingUserInfoKey : Any]

		let items: [String: QueryCoder.ItemType]

		var count: Int? = nil

		var isAtEnd: Bool {
			return self.items[self.currentKey.stringValue] == nil
		}

		var currentIndex: Int = 0

		private var currentKey: QueryCoder.Key {
			return QueryCoder.Key(stringValue: "\(self.currentIndex)")
		}

		init(
			codingPath: [CodingKey],
			userInfo: [CodingUserInfoKey : Any] = [:],
			items: [String: QueryCoder.ItemType]
		) {
			self.codingPath = codingPath
			self.userInfo = userInfo
			self.items = items
		}

		private func next<T>(
			_ transform: (QueryCoder.ItemType) throws -> T
		) throws -> T {

			guard let item = self.items[self.currentKey.stringValue] else {
				throw DecodingError.valueNotFound(
					T.self,
					DecodingError.Context(
						codingPath: self.codingPath + [self.currentKey],
						debugDescription: "Unkeyed container is at end."))
			}

			return try transform(item)

		}

		mutating func decodeNil() throws -> Bool {
			return self.items[self.currentKey.stringValue] == nil
		}

		mutating func nestedContainer<NestedKey>(
			keyedBy type: NestedKey.Type
		) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return KeyedDecodingContainer(
					KeyedContainer<NestedKey>(
						codingPath: self.codingPath + [self.currentKey],
						userInfo: self.userInfo,
						items: [self.currentKey.stringValue: item]))
			}
		}

		mutating func nestedUnkeyedContainer() throws -> any UnkeyedDecodingContainer {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return UnkeyedContainer(
					codingPath: self.codingPath + [self.currentKey],
					userInfo: self.userInfo,
					items: [self.currentKey.stringValue: item])
			}
		}

		mutating func superDecoder() throws -> any Swift.Decoder {
			return QueryCoder.TopLevelDecoder.Decoder(
				codingPath: self.codingPath,
				userInfo: self.userInfo,
				items: self.items)
		}

		mutating func decode(_ type: Bool.Type) throws -> Bool {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return self.decode(
					string: try self.string(
						type,
						for: item))
			}
		}

		mutating func decode(_ type: String.Type) throws -> String {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return try self.string(
					type,
					for: item)
			}
		}

		mutating func decode(_ type: Double.Type) throws -> Double {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return self.decode(
					string: try self.string(
						type,
						for: item))
			}
		}

		mutating func decode(
			_ type: Float.Type
		) throws -> Float {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return Float(self.decode(
					string: try self.string(
						type,
						for: item)))
			}
		}

		mutating func decode(
			_ type: Int.Type
		) throws -> Int {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return Int(self.decode(
					string: try self.string(
						type,
						for: item)))
			}
		}

		mutating func decode(
			_ type: Int8.Type
		) throws -> Int8 {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return Int8(self.decode(
					string: try self.string(
						type,
						for: item)))
			}
		}

		mutating func decode(
			_ type: Int16.Type
		) throws -> Int16 {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return Int16(self.decode(
					string: try self.string(
						type,
						for: item)))
			}
		}

		mutating func decode(
			_ type: Int32.Type
		) throws -> Int32 {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return Int32(self.decode(
					string: try self.string(
						type,
						for: item)))
			}
		}

		mutating func decode(
			_ type: Int64.Type
		) throws -> Int64 {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return Int64(self.decode(
					string: try self.string(
						type,
						for: item)))
			}
		}

		mutating func decode(
			_ type: UInt.Type
		) throws -> UInt {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return UInt(self.decode(
					string: try self.string(
						type,
						for: item)))
			}
		}

		mutating func decode(
			_ type: UInt8.Type
		) throws -> UInt8 {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return UInt8(self.decode(
					string: try self.string(
						type,
						for: item)))
			}
		}

		mutating func decode(
			_ type: UInt16.Type
		) throws -> UInt16 {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return UInt16(self.decode(
					string: try self.string(
						type,
						for: item)))
			}
		}

		mutating func decode(
			_ type: UInt32.Type
		) throws -> UInt32 {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return UInt32(self.decode(
					string: try self.string(
						type,
						for: item)))
			}
		}

		mutating func decode(
			_ type: UInt64.Type
		) throws -> UInt64 {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return UInt64(self.decode(
					string: try self.string(
						type,
						for: item)))
			}
		}

		mutating func decode<T>(
			_ type: T.Type
		) throws -> T where T : Decodable {
			return try self.next { item in
				defer { self.currentIndex += 1 }
				return try T(
					from: QueryCoder.TopLevelDecoder.Decoder(
						codingPath: self.codingPath + [self.currentKey],
						userInfo: self.userInfo,
						items: [self.currentKey.stringValue: item]))
			}
		}

	}

}
