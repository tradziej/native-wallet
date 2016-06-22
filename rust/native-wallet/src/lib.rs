extern crate libc;
extern crate ethstore;

mod accounts;
mod string;

use ethstore::dir::DiskDirectory;
use ethstore::{EthStore, SecretStore};

use accounts::AccountsPtr;
use string::StringPtr;

#[no_mangle]
pub extern fn ethstore_new(path: *mut StringPtr) -> *mut EthStore {
	let path = unsafe { Box::from_raw(path) };
	let dir = DiskDirectory::create(path.as_str()).unwrap();
	let store = EthStore::open(Box::new(dir)).unwrap();

	// put it onto the heap
	let boxed_store = Box::new(store);

	// do not release string ptr, cause we do not own it
	let _ = Box::into_raw(path);

	// make a pointer to store and forget about it
	Box::into_raw(boxed_store)
}

#[no_mangle]
pub unsafe extern fn ethstore_destroy(store: *mut EthStore) {
	// take the ownership back and release it at the end of scope
	let _ = Box::from_raw(store);
}

#[no_mangle]
pub unsafe extern fn ethstore_accounts(store: *mut EthStore) -> *const AccountsPtr {
	use ethstore::ethkey::Address;
	use std::str::FromStr;

	let store = Box::from_raw(store);
	let accounts = store.accounts();
	//let accounts = vec![
		//Address::from_str("5b073e9233944b5e729e46d618f0d8edf3d9c34a").unwrap(),
		//Address::from_str("5b073e9233944b5e729e46d618f0d8edf3d9c34c").unwrap()
	//];
	let result = AccountsPtr::from(accounts);
	let _ = Box::into_raw(store);
	Box::into_raw(Box::new(result))
}

#[no_mangle]
pub unsafe extern fn ethstore_accounts_destroy(accounts: *mut AccountsPtr) {
	let accounts = Box::from_raw(accounts);
	accounts.drop_ptr();
}

#[test]
fn playpen() {
}
