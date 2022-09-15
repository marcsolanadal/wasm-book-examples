const fs = require('fs');

const bytes = fs.readFileSync(__dirname + '/AddInt.wasm');
const arg1 = parseInt(process.argv[2]);
const arg2 = parseInt(process.argv[3]);

WebAssembly.instantiate(new Uint8Array(bytes)).then(obj => {
    let result = obj.instance.exports.AddInt(arg1, arg2);
    console.log(`${arg1} + ${arg2} = ${result}`);
});
