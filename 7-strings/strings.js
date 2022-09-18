const fs = require('fs');

const bytes = fs.readFileSync(__dirname + '/strings.wasm');
let memory = new WebAssembly.Memory({ initial: 1 });
const MAX_MEM = 65535;

let importObject = {
    env: {
        buffer: memory,
        str_pos_len: function(start, len) {
            const bytes = new Uint8Array(memory.buffer, start, len);
            const str = new TextDecoder('utf8').decode(bytes);
            console.log(str);
        },
        null_str: function(start) {
            const bytes = new Uint8Array(memory.buffer, start, MAX_MEM - start);
            const str = new TextDecoder('utf8').decode(bytes).split("\0")[0];
            console.log(str);
        },
        prefix_str: function(start) {
            const len = new Uint8Array(memory.buffer, start, start + 1)[0];
            const bytes = new Uint8Array(memory.buffer, start + 1, len);
            const str = new TextDecoder('utf8').decode(bytes);
            console.log(str);
        }
    }
};

(async () => {
    let obj = await WebAssembly.instantiate(new Uint8Array(bytes), importObject);

    let main = obj.instance.exports.main;

    main();
})();
