const fs = require("fs");

const bytes = fs.readFileSync(__dirname + "/factorial.wasm");
const n = parseInt(process.argv[2] || "1");

let importObject = {
     env: {
         log: function (n, factorial) {
             console.log(`${n}! = ${factorial}`);
         }
     }
};

(async () => {
    let obj = await WebAssembly.instantiate(new Uint8Array(bytes), importObject);
    
    const loop_test = obj.instance.exports.loop_test;

    const factorial = loop_test(n);

    console.log(`result ${n}! = ${factorial}`);

    if(n > 12) {
        console.log(`
        ===============================================================
        Factorials greater than 12 are too large for a 32-bit integer.
        ===============================================================
        `);
    }
})();
