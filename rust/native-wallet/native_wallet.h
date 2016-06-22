#pragma once

#include <stdint.h>

// bytes slice / string
struct string_ptr {
	const uint8_t* ptr;
	size_t len;
};

// ethstore
struct ethstore;

// ethstore constructor
struct ethstore* ethstore_new(const struct string_ptr* slice);

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

