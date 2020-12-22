// const os = require('os');

console.log(process.argv);

const stringAddress = process.argv[2];

const ncs = require('node-c-string');
// const ref = require('ref-napi');
// const ffi = require('ffi-napi');

// const bufhey = Buffer.from('HEYTHISIS A LONG ONE\0');

console.log(ncs(stringAddress));
/*
console.log(bufhey.hexAddress().toString())

var stringPtr = ref.refType(ref.types.CString);

const buf = ref.alloc(ref.types.CString);
buf.readPointer(Buffer.from(stringAddress));

const out = ref.readPointer(buf, 0, 100);

console.log(`BUF de ref is ${out}.` );
*/
// console.log(` BUF de ref is ${buf.deref()}` );


setInterval(() => {
    console.log("Hello from an interval\n");
}, 200);