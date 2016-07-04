extern crate libc;
extern crate ethstore;

mod accounts;
mod string;

use ethstore::{EthStore, SecretStore};
use ethstore::dir::DiskDirectory;
use ethstore::ethkey::{Generator, Random, Address};

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
	let store = Box::from_raw(store);
	let accounts = store.accounts();
	let result = AccountsPtr::from(accounts);
	let _ = Box::into_raw(store);
	Box::into_raw(Box::new(result))
}

#[no_mangle]
pub unsafe extern fn ethstore_accounts_destroy(accounts: *mut AccountsPtr) {
	let accounts = Box::from_raw(accounts);
	accounts.drop_ptr();
}

#[no_mangle]
pub unsafe extern fn ethstore_account_new_random(store: *mut EthStore, password: *mut StringPtr) -> *const Address {
	let store = Box::from_raw(store);
	let password = Box::from_raw(password);

	let kp = Random.generate().unwrap();
	let address = store.insert_account(kp.secret().clone(), password.as_str()).unwrap();

	let _ = Box::into_raw(store);
	let _ = Box::into_raw(password);
	Box::into_raw(Box::new(address))
}

#[no_mangle]
pub unsafe extern fn ethstore_account_destroy(account: *mut Address) {
	let _ = Box::from_raw(account);
}

#[test]
fn playpen() {
}
