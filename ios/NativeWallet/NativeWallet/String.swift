//
//  String.swift
//  NativeWallet
//
//  Created by Marek Kotewicz on 22/06/16.
//  Copyright © 2016 Marek Kotewicz. All rights reserved.
//

import Foundation

extension String {
	func asPtr() -> string_ptr {
		let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
		return string_ptr(ptr: UnsafePointer(data.bytes), len: data.length)
	}
}