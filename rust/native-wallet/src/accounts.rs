use std::mem;
use libc::size_t;
use ethstore::ethkey::Address;

#[repr(C)]
pub struct AccountsPtr {
	pub ptr: *mut Address,
	pub len: size_t,
	pub cap: size_t,
}

impl From<Vec<Address>> for AccountsPtr {
	fn from(mut a: Vec<Address>) -> Self {
		let accounts = AccountsPtr {
			ptr: a.as_mut_ptr(),
			len: a.len() as size_t,
			cap: a.capacity(),
		};

		mem::forget(a);

		accounts
	}
}

impl AccountsPtr {
	// can be called only once. is not implemented as a trait cause AccountsPtr has repr(C)
	pub unsafe fn drop_ptr(&self) {
		let _ = Vec::from_raw_parts(self.ptr, self.len, self.cap);
	}
}
