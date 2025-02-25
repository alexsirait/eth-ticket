require("@nomicfoundation/hardhat-toolbox");

module.exports = {
    solidity: "0.8.20",
    networks: {
        ganache: {
            url: "http://127.0.0.1:7545", // Default Ganache RPC URL
            accounts: [
                "0x4d1d735e6a40ed07753e742818d464af55163e0bca450bc7c655090f6e03b7c1",
                "0x599f473fa0d8f44f149fc29586dfcce0ddc079bd6ffef11cfab16634bebf851b",
                "0x98690c6170049d43c0c33807aa9d5e012a31f69e09a6a7ff27e0a443bd25943e"
            ] // Ambil dari Ganache
        }
    }
};
