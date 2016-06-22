//
//  DiskDirectory.swift
//  NativeWallet
//
//  Created by Marek Kotewicz on 21/06/16.
//  Copyright © 2016 Marek Kotewicz. All rights reserved.
//

import Foundation

struct Account {
	let address: [UInt8]
	
	func asString() -> String {
		return "0x" + address.map { (x) -> String in
			String(format: "%02x", x)
		}.joinWithSeparator("")
	}
};

class EthStore
{
	private let raw: COpaquePointer
	
	init(path: String) {
		let data = path.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
		var bytes = string_ptr(ptr: UnsafePointer(data.bytes), len: data.length)
		raw = ethstore_new(&bytes)	
	}
	
	deinit {
		ethstore_destroy(raw)
	}
	
	func accounts() -> [Account] {
		let accounts = ethstore_accounts(raw)
		
		var result: [Account] = [];
		for i in 0 ..< accounts.memory.len {
			let ptr: UnsafePointer<UInt8> = accounts.memory.ptr.advancedBy(i * 20)
			let buffer: UnsafeBufferPointer<UInt8> = UnsafeBufferPointer(start: ptr, count: 20)
			let account = Account (address: Array(buffer))
			result.append(account)
		}

		ethstore_accounts_destroy(accounts)
		return result
	}
}