/// <reference path="components/core-min.js"/*tpa=http://www.pdsrd.gov.cn:7081/HUI/external/CryptoJS/components/core-min.js*/ />
/// <reference path="components/aes-min.js"/*tpa=http://www.pdsrd.gov.cn:7081/HUI/external/CryptoJS/components/aes-min.js*/ />

var HzCrypto = {
    Encrypt: function (plaintText) {
        var rsEncrypt = CryptoJS.AES.encrypt(plaintText, this.GenKey(), {
            iv: this.GenIV(),
            mode: CryptoJS.mode.ECB,
            padding: CryptoJS.pad.Pkcs7
        });

        return CryptoJS.enc.Base64.stringify(rsEncrypt.ciphertext);
    },
    GenKey: function () {
        return CryptoJS.enc.Utf8.parse('F8Q0uft9cgky5Q50ImqQXg9inKg5q66Q');
    },
    GenIV: function () {
        return CryptoJS.enc.Utf8.parse('1234567890123456');
    }
};