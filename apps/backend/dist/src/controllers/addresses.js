"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteAddress = exports.updateAddress = exports.createAddress = exports.getAddresses = void 0;
const getAddresses = (req, res) => {
    res.json({
        msg: "getAddresses",
    });
};
exports.getAddresses = getAddresses;
const createAddress = (req, res) => {
    res.json({
        msg: "createAddress",
    });
};
exports.createAddress = createAddress;
const updateAddress = (req, res) => {
    res.json({
        msg: "updateAddress",
    });
};
exports.updateAddress = updateAddress;
const deleteAddress = (req, res) => {
    res.json({
        msg: "deleteAddress",
    });
};
exports.deleteAddress = deleteAddress;
//# sourceMappingURL=addresses.js.map