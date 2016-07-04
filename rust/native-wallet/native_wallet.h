#pragma once

#include <stdint.h>

// string
struct string_ptr {
	const uint8_t* ptr;
	size_t len;
};

// ethstore
struct ethstore;

// ethstore constructor
struct ethstore* ethstore_new(const struct string_ptr* path);

// ethstore destructor
void ethstore_destroy(struct ethstore* store);

// addresses
struct Accounts {
	const uint8_t* ptr;
	size_t len;
	size_t cap;
};

// vector of addresses
struct Accounts* ethstore_accounts(const struct ethstore* store);

// release vector of addresses
void ethstore_accounts_destroy(struct Accounts* acc);

typedef uint8_t Account;

// creates new random account
Account* ethstore_account_new_random(const struct ethstore* store, const struct string_ptr* password);

// release random account ptr
void ethstore_account_destroy(Account* acc);
