// Copyright (c) 2019 Alexander Medvednikov. All rights reserved.
// Use of this source code is governed by an MIT license
// that can be found in the LICENSE file.

module builtin

struct Option {
	data [500]byte 
	error string
	ok    bool
}

// `fn foo() ?Foo { return foo }` => `fn foo() ?Foo { return opt_ok(foo); }`
fn opt_ok(data voidptr, size int) Option {
	if size >= 500 {
		panic('option size too big: $size (max is 500), this is a temporary limit') 
	} 
	res := Option { 
		ok: true
	}
	C.memcpy(res.data, data, size) 
	return res 
}

pub fn error(s string) Option {
	return Option {
		error: s
	}
}


