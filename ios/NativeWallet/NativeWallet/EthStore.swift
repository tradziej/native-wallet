//
//  EthStore.swift
//  NativeWallet
//
//  Created by Marek Kotewicz on 21/06/16.
//  Copyright © 2016 Marek Kotewicz. All rights reserved.
//

import Foundation

struct Account {
	let address: [UInt8]
	
	init(ptr: UnsafePointer<UInt8>) {
		address = Array(UnsafeBufferPointer(start: ptr, count: 20))
	}
	
	init(a: [UInt8]) {
		address = a
	}
	
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
		var path_ptr = path.asPtr();
		raw = ethstore_new(&path_ptr)
	}
	
	deinit {
		ethstore_destroy(raw)
	}
	
	func new_random_account(password: String) -> Account {
		var password_ptr = password.asPtr();
		let account = ethstore_account_new_random(raw, &password_ptr)
		let result = Account(ptr: account)
		ethstore_account_destroy(account)
		return result
	}
	
	func accounts() -> [Account] {
		let accounts = ethstore_accounts(raw)
		
		var result: [Account] = [];
		for i in 0 ..< accounts.memory.len {
			let account = Account(ptr: accounts.memory.ptr.advancedBy(i * 20))
			result.append(account)
		}

		ethstore_accounts_destroy(accounts)
		return result
	}
}