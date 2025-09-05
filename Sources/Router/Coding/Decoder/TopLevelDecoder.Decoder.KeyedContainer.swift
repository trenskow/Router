//
//  TopLevelDecoder.Decoder.KeyedContainer.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import Foundation

extension QueryCoder.TopLevelDecoder.Decoder {

	struct KeyedContainer<Key: CodingKey>: KeyedDecodingContainerProtocol, ValueDecoder {

		let codingPath: [CodingKey]
		let userInfo: [CodingUserInfoKey : Any]

		let items: [String: QueryCoder.ItemType]

		var allKeys: [Key] {
			return items
				.keys
				.compactMap({ Key(stringValue: $0) })
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

		func contains(
			_ key: Key
		) -> Bool {
			return items[key.stringValue] != nil
		}

		func decodeNil(
			forKey key: Key
		) throws -> Bool {
			return !self.contains(key)
		}

		func nestedContainer<NestedKey>(
			keyedBy type: NestedKey.Type,
			forKey key: Key
		) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {

			guard
				let item = items[key.stringValue],
				case .container(let dictionary) = item
			else {
				throw DecodingError.keyNotFound(
					key,
					DecodingError.Context(
						codingPath: codingPath,
						debugDescription: "No nested container found for key \(key.stringValue)."))
			}

			return KeyedDecodingContainer(
				KeyedContainer<NestedKey>(
					codingPath: self.codingPath + [key],
					items: dictionary))

		}

		func nestedUnkeyedContainer(
			forKey key: Key
		) throws -> any UnkeyedDecodingContainer {

			guard
				let item = items[key.stringValue],
				case .container(let dictionary) = item
			else {
				throw DecodingError.keyNotFound(
					key,
					DecodingError.Context(
						codingPath: codingPath,
						debugDescription: "No nested container found for key \(key.stringValue)."))
			}

			return UnkeyedContainer(
				codingPath: self.codingPath + [key],
				userInfo: self.userInfo,
				items: dictionary)

		}

		func superDecoder() throws -> any Swift.Decoder {
			return QueryCoder.TopLevelDecoder.Decoder(
				codingPath: self.codingPath,
				userInfo: self.userInfo,
				items: self.items)
		}

		func superDecoder(
			forKey key: Key
		) throws -> any Swift.Decoder {

			guard
				let item = items[key.stringValue]
			else { throw DecodingError.keyNotFound(
				key,
				DecodingError.Context(
					codingPath: codingPath,
					debugDescription: "No nested container found for key \(key.stringValue)."))
			}

			return QueryCoder.TopLevelDecoder.Decoder(
				codingPath: codingPath + [key],
				userInfo: self.userInfo,
				items: [key.stringValue: item])

		}

		private func string<T>(
			_ type: T.Type,
			for key: Key
		) throws -> String {

			guard
				let item = items[key.stringValue]
			else {
				throw DecodingError.keyNotFound(
					key,
					DecodingError.Context(
						codingPath: codingPath,
						debugDescription: "No value found for key \(key.stringValue)."))
			}

			return try self.string(
				type,
				for: item)

		}

		func decode(
			_ type: Bool.Type,
			forKey key: Key
		) throws -> Bool {
			return self.decode(
				string: try self.string(
					Bool.self,
				 for: key))
		}

		func decode(
			_ type: String.Type,
			forKey key: Key
		) throws -> String {
			return try self.string(
				String.self,
				for: key)
		}

		func decode(
			_ type: Double.Type,
			forKey key: Key
		) throws -> Double {
			return self.decode(
				string: try self.string(
					Bool.self,
					for: key))
		}

		func decode(
			_ type: Float.Type,
			forKey key: Key
		) throws -> Float {
			return Float(self.decode(
				string: try self.string(
					type,
					for: key)))
		}

		func decode(
			_ type: Int.Type,
			forKey key: Key
		) throws -> Int {
			return Int(self.decode(
				string: try self.string(
					type,
					for: key)))
		}

		func decode(
			_ type: Int8.Type,
			forKey key: Key
		) throws -> Int8 {
			return Int8(self.decode(
				string: try self.string(
					type,
					for: key)))
		}

		func decode(
			_ type: Int16.Type,
			forKey key: Key
		) throws -> Int16 {
			return Int16(self.decode(
				string: try self.string(
					type,
					for: key)))
		}

		func decode(
			_ type: Int32.Type,
			forKey key: Key
		) throws -> Int32 {
			return Int32(self.decode(
				string: try self.string(
					type,
					for: key)))
		}

		func decode(
			_ type: Int64.Type,
			forKey key: Key
		) throws -> Int64 {
			return Int64(self.decode(
				string: try self.string(
					type,
					for: key)))
		}

		func decode(
			_ type: UInt.Type,
			forKey key: Key
		) throws -> UInt {
			return UInt(self.decode(
				string: try self.string(
					type,
					for: key)))
		}

		func decode(
			_ type: UInt8.Type,
			forKey key: Key
		) throws -> UInt8 {
			return UInt8(self.decode(
				string: try self.string(
					type,
					for: key)))
		}

		func decode(
			_ type: UInt16.Type,
			forKey key: Key
		) throws -> UInt16 {
			return UInt16(self.decode(
				string: try self.string(
					type,
					for: key)))
		}

		func decode(
			_ type: UInt32.Type,
			forKey key: Key
		) throws -> UInt32 {
			return UInt32(self.decode(
				string: try self.string(
					type,
					for: key)))
		}

		func decode(
			_ type: UInt64.Type,
			forKey key: Key
		) throws -> UInt64 {
			return UInt64(self.decode(
				string: try self.string(
					type,
					for: key)))
		}

		func decode<T>(
			_ type: T.Type,
			forKey key: Key
		) throws -> T where T : Decodable {
			return try T(from: QueryCoder.TopLevelDecoder.Decoder(
				codingPath: self.codingPath + [key],
				userInfo: self.userInfo,
				items: items))
		}

	}

}
